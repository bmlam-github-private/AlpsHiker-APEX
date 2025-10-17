create or replace package body alph_pkg_mountain as

    c_nl CONSTANT VARCHAR2(10) := chr(10);
    
/* suppose we have collected the locations of a bunch of mountains and want to 
* import these into the staging table 
*/
procedure import_mountain_csv (
	p_csv_content varchar2
	,p_ignore_csv BOOLEAN DEFAULT FALSE
) as
	l_row_cnt INTEGER;
begin
--raise_application_error( -20001, 'not sure what this procedure is good for!');
	IF NOT p_ignore_csv THEN
		PKG_UTL_CSV.INSERT2TABLE(
			P_CSV_STRING => p_csv_content 
			,P_TARGET_OBJECT =>   upper('alph_imp_mountain')
		--    ,P_TARGET_SCHEMA =>     ?P_TARGET_SCHEMA
			,P_DELETE_BEFORE_INSERT2TABLE => true
			,P_COL_SEP =>   ';'
	--     ,P_DECIMAL_POINT_CHAR =>        ?P_DECIMAL_POINT_CHAR
			,P_DATE_FORMAT =>     'yyyy.mm.dd'
			,P_CREATE_TABLE =>   false);
	END IF;
	-- merge alph_mountain groups
	MERGE into alph_mountain_group tgt
	USING	(
		SELECT DISTINCT trim( mountain_group1) as alph_mountain_group
		FROM alph_imp_mountain
		WHERE trim( mountain_group1 ) IS NOT NULL
		UNION
		SELECT DISTINCT trim( mountain_group2) as alph_mountain_group
		FROM alph_imp_mountain
		WHERE trim( mountain_group2 ) IS NOT NULL
	) src ON ( src.alph_mountain_group = tgt.name )
	WHEN NOT MATCHED THEN
		INSERT ( name )
		VALUES ( src.alph_mountain_group ) -- id will be filled by trigger
	;
	l_row_cnt := SQL%ROWCOUNT;
	COMMIT;
	loginfo( p_text=> 'Rows merged into alph_mountain_group: '||l_row_cnt );
	-- merge mountains 
	-- update the target row only if its altitude and coordinates are still empty!
	MERGE into alph_mountain tgt 
	USING	(
		WITH imp_ AS (
			SELECT replace( trim( i.name), ' ', '_' ) as mountain_name
			,gracious_to_number( i.altitude) altitude
			,ROUND(gracious_to_number( i.latitude) , 10) latitude
			,ROUND(gracious_to_number( i.longitude), 10) longitude
			,trim( i.remarks ) remarks
			,CASE WHEN mountain_group1 IS NULL THEN mountain_group2 ELSE mountain_group1 END as alph_mountain_group
			FROM alph_imp_mountain i
		), distinct_ AS (
			SELECT 
        i.mountain_name
			, i.latitude
			, i.longitude
			, max( i.alph_mountain_group ) alph_mountain_group
			, max( i.remarks ) remarks
			, max( i.altitude ) altitude
			FROM imp_ i
      GROUP BY  i.mountain_name
			, i.latitude
			, i.longitude
		), get_mount_with_grp_ AS (
			SELECT d.mountain_name
			, d.altitude
			, d.latitude
			, d.longitude
			, d.remarks
			,g.id mountain_group_id 
			FROM distinct_ d
			LEFT JOIN alph_mountain_group g
			ON ( g.name = trim( d.alph_mountain_group ) )
		), for_agg AS ( 
            SELECT mountain_name, altitude, latitude, longitude
                , mountain_group_id, remarks
            FROM get_mount_with_grp_
            WHERE 1 = 1
                AND (1=0 -- apply common sense here
                or( abs( longitude ) <= 180     and abs( latitude ) <= 180 )
                or ( longitude is null and latitude is null )
                )
                AND mountain_name IS NOT NULL
        ), agg AS (
            SELECT fa.*
                , count(1) over (partition by mountain_name ) occ 
            FROM for_agg fa 
        )
        SELECT a.*
        FROM agg a 
        WHERE occ = 1
        ) src ON ( src.mountain_name = tgt.name_display AND NVL(src.mountain_group_id, -1 ) = NVL(tgt.mountain_group_id, -1 ) )
	WHEN NOT MATCHED THEN
		INSERT ( name_display, remarks
				,altitude, 	longitude,	latitude
				,mountain_group_id 
		)	VALUES ( src.mountain_name, src.remarks -- id will be filled by trigger
				,src.altitude, src.longitude,	src.latitude
				,src.mountain_group_id 
		) 
	WHEN MATCHED THEN 
		UPDATE 
		SET tgt.altitude = CASE WHEN tgt.altitude IS NULL THEN src.altitude ELSE tgt.altitude END
			,tgt.latitude = src.latitude
			,tgt.longitude = src.longitude
			,tgt.remarks = CASE WHEN tgt.remarks IS NULL THEN src.remarks ELSE src.remarks||'. '||tgt.remarks END
		WHERE 1 = 0 
			OR ( tgt.altitude IS NULL and src.altitude IS NOT NULL )
		   OR ( 	 tgt.longitude IS 	NULL  AND tgt.latitude IS NULL 
				AND src.longitude IS NOT NULL AND src.latitude IS NOT NULL 
			)
	;
	l_row_cnt := SQL%ROWCOUNT;
	COMMIT;
	loginfo( p_text=> 'Rows merged into alph_mountain: '||l_row_cnt );
end import_mountain_csv;

/* suppose we have found more precise locations for mountains which we have already imported
*/ 
procedure update_location_with_csv (
	p_csv_content_no_header varchar2
	,p_ignore_csv BOOLEAN DEFAULT FALSE
) as
l_row_cnt INTEGER;
begin
    IF NOT p_ignore_csv THEN
        PKG_UTL_CSV.INSERT2TABLE(
            P_CSV_STRING => p_csv_content_no_header
            ,P_TARGET_OBJECT =>   upper('alph_imp_mountain')
            ,P_DELETE_BEFORE_INSERT2TABLE => true
            ,P_COL_SEP =>   '|'
            ,p_standalone_head_line =>     'NAME|ALTITUDE|LATITUDE|LONGITUDE|REMARKS'
            ,P_CREATE_TABLE =>   false)
        ;
    END IF;
    
    -- merge mountains
    -- update the target row only if its altitude and coordinates are still empty!
    
    MERGE into alph_mountain tgt
    USING	(
        WITH imp_ AS (
            SELECT trim( i.name) as mountain_name
                ,gracious_to_number( i.altitude) altitude
                ,ROUND(gracious_to_number( i.latitude) , 10) latitude
                ,ROUND(gracious_to_number( i.longitude), 10) longitude
                ,trim( i.remarks ) remarks
            FROM alph_imp_mountain i
            ), distinct_ AS (
            SELECT DISTINCT i.mountain_name
                , i.altitude
                , i.latitude
                , i.longitude
                , REGEXP_REPLACE( i.remarks, '^mount_id:(\d+)', '\1' ) AS mountain_id
            FROM imp_ i
            )
        SELECT mountain_id, altitude, latitude, longitude
        FROM distinct_
        WHERE 1 = 1
        AND (1=0 -- apply common sense here
          or( abs( longitude ) <= 180		and abs( latitude ) <= 180 )
        )
        AND mountain_id IS NOT NULL
    ) src ON ( src.mountain_id = tgt.id )
    WHEN MATCHED THEN
    UPDATE
        SET tgt.altitude = CASE WHEN tgt.altitude IS NULL THEN src.altitude ELSE tgt.altitude END
        ,tgt.latitude = src.latitude
        ,tgt.longitude = src.longitude
    ;
    l_row_cnt := SQL%ROWCOUNT;
    COMMIT;
    loginfo( p_text=> 'Rows merged into alph_mountain: '||l_row_cnt );
    
end update_location_with_csv;

PROCEDURE merge_mountain_from_imp AS
BEGIN
        FOR rec IN (
          WITH imp_ AS (
                    SELECT trim( i.name) as mountain_name
                        ,gracious_to_number( i.altitude) altitude
                        ,ROUND(gracious_to_number( i.latitude) , 10) latitude
                        ,ROUND(gracious_to_number( i.longitude), 10) longitude
                        ,trim( i.remarks ) remarks
                    FROM alph_imp_mountain i
                    ), dist_imp_ AS (
                    SELECT DISTINCT i.mountain_name
                        , i.altitude
                        , i.latitude
                        , i.longitude
                        , REGEXP_REPLACE( i.remarks, '^mount_id:(\d+)', '\1' ) AS mountain_id
                    FROM imp_ i
                )
            SELECT i.mountain_NAME
            , i.altitude i_alt
            , i.latitude i_lat
            , i.longitude i_lon
            , db.altitude  db_alt
            , db.latitude  db_lat
            , db.longitude db_lon
            , db.id mountain_id
            FROM dist_imp_ i
            LEFT JOIN alph_mountain db
            ON ( i.mountain_name = db.name_display)
            WHERE i.altitude IS NOT NULL AND i.latitude IS NOT NULL AND i.longitude IS NOT NULL
        ) LOOP
            CASE
            WHEN rec.mountain_id IS NULL THEN
                INSERT INTO alph_mountain ( name_display, altitude, latitude, longitude )
                    VALUES ( rec.mountain_name, rec.i_alt, rec.i_lat, rec.i_lon );
            WHEN rec.mountain_id IS NOT NULL THEN
                CASE 
                WHEN ( rec.db_alt IS NULL AND rec.db_lat IS NULL AND rec.db_lon IS NULL ) THEN
                    UPDATE alph_mountain 
                    SET altitude = rec.i_alt, latitude = rec.i_lat, longitude = rec.i_lon
                    WHERE id = rec.mountain_id;
                WHEN abs( rec.db_alt - rec.i_alt ) < 5 AND rec.db_lat IS NULL AND rec.db_lon IS NULL THEN
                    UPDATE alph_mountain 
                    SET latitude = rec.i_lat, longitude = rec.i_lon
                    WHERE id = rec.mountain_id;
                WHEN abs( rec.db_lat - rec.i_lat ) < 0.001 AND abs( rec.db_lON - rec.i_lON ) < 0.001 AND rec.db_alt IS NULL THEN
                    UPDATE alph_mountain 
                    SET altitude = rec.i_alt
                    WHERE id = rec.mountain_id;
                ELSE NULL;
               END CASE; -- ID NOT NULL
            END CASE; -- check record
        END LOOP;
        COMMIT;
    END merge_mountain_from_imp;
    
    PROCEDURE consolidate_mountain 
    AS
    BEGIN
        FOR rec IN (
            with d_ as (
                select count(1) over (partition by m.name_display, m.altitude ) dupes
                ,m.*
                ,g.name group_name
                from alph_mountain m
                LEFT JOIN alph_mountain_group g
                ON ( m.mountain_group_id = g.id ) 
            ) select * from d_ where dupes > 1
        ) LOOP
            IF rec.group_name IS NULL AND rec.latitude is not null THEN
                UPDATE alph_mountain 
                SET latitude = rec.latitude, longitude = rec.longitude
                WHERE 1=1
                  and name_display = rec.name_display and altitude = rec.altitude and mountain_group_id is not null
                  and latitude is null
                  and id != rec.id
                ;
            END IF;
            NULL;
        END LOOP;
        COMMIT;
        -- Mountains which has a backup with alph_mountain group. Fixme: we should be more sophisticated by checking the REMARKS
        -- column agains the alph_mountain group name
        DELETE alph_mountain tgt
        WHERE mountain_group_id IS NULL 
          AND EXISTS (
            SELECT 1 FROM alph_mountain src
            WHERE src.id <> tgt.id
              AND src.name_display = tgt.name_display AND src.altitude = tgt.altitude
              AND src.latitude IS NOT NULL
              AND src.mountain_group_id IS NOT NULL
          );     
        COmmit;
        -- delete dupes without coordinates anyway
            DELETE alph_mountain tgt
        WHERE mountain_group_id IS NULL AND latitude IS NULL
          AND EXISTS (
            SELECT 1 FROM alph_mountain src
            WHERE src.id <> tgt.id
              AND src.name_display = tgt.name_display AND src.altitude = tgt.altitude
              AND src.latitude IS NULL
              AND src.mountain_group_id IS NOT NULL
          );
        COMMIT;
        -- dupes because the same alph_mountain in multiple groups
        DELETE alph_mountain tgt
        WHERE mountain_group_id IS NOT NULL AND REMARKS IS NULL
          AND EXISTS (
            SELECT 1 FROM alph_mountain src
            WHERE src.id <> tgt.id
              AND src.name_display = tgt.name_display AND src.altitude = tgt.altitude
              AND ( ABS(src.latitude  - tgt.latitude) < 0.0001 AND ABS(src.longitude - tgt.longitude) < 0.0001
                    OR tgt.latitude IS NULL 
              )
              AND src.REMARKS IS NOT NULL
          );
        COMMIT;
    END consolidate_mountain;

FUNCTION double_quote ( pi_attribute VARCHAR ) -- internal use only 
RETURN VARCHAR2 
AS
BEGIN 
    RETURN '"'||pi_attribute||'"';
END double_quote
; 
/* Suppose we have imported a GPX as BLOB into the table TEMP_BLOB and want extract 
* various attributes of this track. 
*/
PROCEDURE extract_track_info ( 
     pi_blob_id   IN    NUMBER 
    ,po_info_json OUT   VARCHAR2 
) AS 
    c_json_starter CONSTANT VARCHAR2(10) := '{' ;
BEGIN
    po_info_json := c_json_starter;
    FOR lr IN ( 
        WITH from_blob as ( 
            select 
                to_clob( blob_content ) as_clob,
                b.*
            from temp_blob b
            WHERE id = pi_blob_id
        )
        select x.track_name, x.link_href 
        --, f.as_clob
        from from_blob f
        CROSS JOIN     XMLTable(
                 XMLNamespaces(DEFAULT 'http://www.topografix.com/GPX/1/1'),
                 '/gpx'
                 PASSING  xmlType ( f.as_clob )
                 COLUMNS
                     track_name VARCHAR2(100) PATH 'trk/name'
                    ,link_href VARCHAR2(100) PATH 'metadata/link/@href' 
             ) x
    ) LOOP 
        IF lr.track_name IS NOT NULL THEN 
            po_info_json := po_info_json
                ||CASE WHEN po_info_json != c_json_starter THEN ', '  END 
                || double_quote( 'track_name' ) ||':'||double_quote( lr.track_name )
            ;
        END IF;
        IF lr.link_href IS NOT NULL THEN 
            po_info_json := po_info_json
                ||CASE WHEN po_info_json != c_json_starter THEN ', '  END 
                || double_quote( 'link_href' ) ||':'||double_quote( lr.link_href )
            ;
        END IF;

        EXIT ;
    END LOOP; -- one_pass_only

    po_info_json := po_info_json ||'}';
EXCEPTION 
    WHEN OTHERS THEN
        logerror ( null, sqlcode, dbms_utility.format_error_backtrace );
END extract_track_info;

PROCEDURE init_application_items 
AS 
BEGIN 
    NULL;
    -- we may not need c_selected_tracks_appl_item_name if we reference the collection name using the package constant directly in APEX! 
    --apex_util.set_session_state(  c_selected_tracks_appl_item_name , c_selected_tracks_appl_item_value );
END init_application_items;

PROCEDURE switch_track_selection_status 
    ( p_track_id    NUMBER 
    , p_on          BOOLEAN 
    )
AS 
    v_col_exists BOOLEAN;
    v_seq NUMBER; 
BEGIN
    v_col_exists := apex_collection.collection_exists( c_selected_tracks_collection_name );
    dbms_output.put_line ( 'Ln'||$$plsql_line || ' v_col_exists:'||sys.diutil.bool_to_int( v_col_exists ) );
    BEGIN 
            SELECT seq_id
            INTO v_seq 
            FROM apex_collections
            WHERE n001 = p_track_id
              AND collection_name = c_selected_tracks_collection_name
            ; 
    EXCEPTION 
        WHEN no_data_found then  null;
    END;
    dbms_output.put_line ( 'Ln'||$$plsql_line || ' v_seq:'||v_seq );
    IF  NOT v_col_exists  AND p_on = FALSE 
    -- very weird if we are supposed to delete a member of a collection does not exist yet
    THEN 
        raise_application_error( -20001, 'Collection '||c_selected_tracks_collection_name || ' is non-existent!');
    END IF;

    IF p_on 
    THEN 
    dbms_output.put_line ( 'Ln'||$$plsql_line);
        IF NOT v_col_exists 
        THEN
    dbms_output.put_line ( 'Ln'||$$plsql_line);
            apex_collection.create_collection( c_selected_tracks_collection_name );
        END IF; -- v_col_exists 

        IF v_seq IS NULL 
        THEN
    dbms_output.put_line ( 'Ln'||$$plsql_line);
            apex_collection.add_member( c_selected_tracks_collection_name
                        , p_n001 => p_track_id
                );
        END IF;
    ELSE -- switch OFF
    dbms_output.put_line ( 'Ln'||$$plsql_line);
        IF v_seq IS NOT NULL 
        THEN 
    dbms_output.put_line ( 'Ln'||$$plsql_line);
            apex_collection.delete_member( c_selected_tracks_collection_name, p_seq => v_seq );
        END IF;
    END IF;

END switch_track_selection_status;

PROCEDURE mark_selected_tracks 
    ( p_data VARCHAR2 
     ,p_replace_current_selected BOOLEAN DEFAULT FALSE   
     ,p_input_format VARCHAR2 DEFAULT 'BLANK_SEPARATED'
    )
AS 
BEGIN 
    loginfo( $$PLSQL_UNIT||';'||$$PLSQL_LINE, p_text=> 'p_json_data: ' || p_data ||' p_replace_current_selected:' ||sys.diutil.bool_to_int(p_replace_current_selected) );
    IF p_replace_current_selected 
    THEN 
        FOR rec_sel IN (
            SELECT track_id
            FROM v_alph_selected_tracks
        ) LOOP   
            switch_track_selection_status( p_track_id=> rec_sel.track_id , p_on => FALSE );
        END LOOP;
    END IF;

    CASE p_input_format  
    WHEN 'JSON' THEN 
        FOR rec IN (
            WITH json_data AS (
                SELECT track_id 
                    , selected 
                FROM JSON_TABLE( p_data , '$[*]'
                        COLUMNS(track_id,  selected )
                        )
            )
            SELECT *
            FROM json_data
        ) LOOP 
             pck_std_log.inf ( ' track_id: '|| rec.track_id|| ' selected: '|| rec.selected );
            switch_track_selection_status( p_track_id=> rec.track_id , p_on => TRUE );
        END LOOP;
    WHEN 'BLANK_SEPARATED' THEN  
        FOR rec IN ( 
            SELECT REGEXP_SUBSTR( p_data, '[^ ]+', 1, LEVEL) AS track_id 
            FROM dual
            CONNECT BY REGEXP_SUBSTR( p_data, '[^ ]+', 1, LEVEL) IS NOT NULL
        ) LOOP 
             pck_std_log.inf ( ' track_id: '|| rec.track_id );
            switch_track_selection_status( p_track_id=> rec.track_id , p_on => TRUE );
        END LOOP;

    ELSE 
             pck_std_log.inf ( ' input format '|| p_input_format || ' not yet implemented ' );
    END CASE;
    pck_std_log.inf ( ' tracks in collection: ' ||  apex_collection.collection_member_count( c_selected_tracks_collection_name ) );

--EXCEPTION
--    WHEN OTHERS THEN
--        pck_std_log.error( a_comp=> $$PLSQL_UNIT, a_subcomp=> 'Ln'||$$plsql_line
--            , a_err_code=> sqlcode, a_text=>  sqlerrm ||c_nl||dbms_utility.format_call_stack );
--        RAISE;
END mark_selected_tracks;

FUNCTION get_selected_tracks_collection_name 
RETURN VARCHAR2 
AS 
BEGIN return c_selected_tracks_collection_name;
END get_selected_tracks_collection_name;
--
FUNCTION get_set_of_landmarks
( pi_min_alti NUMBER 
, pi_max_alti NUMBER 
, pi_north_est  NUMBER 
, pi_south_est  NUMBER 
, pi_north_west NUMBER 
, pi_south_west NUMBER 
) RETURN landmark_col
AS 
    l_return    landmark_col ;
BEGIN 
    RETURN l_return;
END get_set_of_landmarks;
--
end; -- PACKAGE 
/

show errors package body 

