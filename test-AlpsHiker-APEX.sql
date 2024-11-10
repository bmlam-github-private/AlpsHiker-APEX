start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/alph_pkg_mountain-impl.sql
;
start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/test-alph_pkg_mountain-mark_selected_tracks.sql "7 45 65"
;
sta /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/tables/alph_major_locations.sql
;
sta /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/functions/world_tiles_n_by_m.sql
;
sta /Users/bmlam/Library/CloudStorage/Dropbox/git_clones/mailto-git_clones/lam_personal/hotspots/improve_apex/test-create_apex_session.sql  115 LAM
;
alter session set nls_date_format = 'yyyy.mm.dd hh24:mi:ss'
;
select * from log_table_v2
where 1=1
--  AND caller_position not like 'procedure LAM.LOOP_CREATE_USER_REQS:%' 
order by log_ts desc fetch first 100 rows only
;
select * from v_alph_selected_tracks_agg
;
SELECT tr.id, tr.name_display, tr.date_started
 , name_display||' started '||to_char( date_started , 'yyyy.mm.dd hh24:mi') AS tool_tip
-- , sdo_util.to_geojson( sdo_geom.sdo_Mbr( sdo_geo ) ) bounding_box_json
, sdo_util.to_geojson ( sdo_geo ) geojs
, tr.sdo_geo, tr.remarks 
, rownum AS layer_id 
--, sdo_util.from_geojson ( gpx_data ) sdo_geo
, gpx_data
FROM alph_tracks tr
JOIN v_alph_selected_tracks sl ON sl.track_id = tr.id
WHERE 1=1
--  AND id = 82 
  AND tr.sdo_geo IS NOT NULL 
and rownum <= 5
order by id desc 
;
SELECT tr.id
, bb_vert.x
, bb_vert.y
, avg( x ) over ( partition by tr.id ) mid_x
, avg( y ) over ( partition by tr.id ) mid_y
FROM alph_tracks tr
CROSS JOIN TABLE( sdo_util.getVertices ( sdo_geom.sdo_Mbr /*bounding only requires 2 geo points*/ ( tr.sdo_geo ) ) ) bb_vert
WHERE 1=1
  AND tr.name_display = 'Dalco'
  ;

select '' x
,sdo_util.to_geojson( sdo_geo ) gj
--    , DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(gpx_data), 1 ) digest
--    , dbms_lob.getlength( gpx_data ) len 
, tr.*
from alph_tracks tr
where 1=1
--  AND sdo_geo IS NOT NULL 
order by id
;

WITH from_blob as ( 
    select 
    to_clob( blob_content ) as_clob,
    b.* from test_blob b
)
select x.name_value, x.link_href_value 
, f.as_clob
from from_blob f
CROSS JOIN     XMLTable(
         XMLNamespaces(DEFAULT 'http://www.topografix.com/GPX/1/1'),
         '/gpx'
         PASSING  xmlType ( f.as_clob )
         COLUMNS
             name_value VARCHAR2(100) PATH 'trk/name'
            ,link_href_value VARCHAR2(100) PATH 'metadata/link/@href' 
     ) x
--select * from from_blob
     ;

select * 
from apex_application_temp_files
;

SELECT 
        jt.*
FROM    JSON_TABLE(
        '{"track_name":"Der Bastione und Santa Barbara, die Herrschaften von Riva del Garda", "link_href":"https://www.bergfex.at"}',
        '$'
        COLUMNS (
            track_name VARCHAR2(200 char) PATH '$.track_name'
        ,   link_href VARCHAR2(100 char) PATH '$.link_href'
        )
    ) jt
;

-- to view, we may need to attach to a given session!
SELECT * FROM apex_collections
;
SELECT seq_id, n001 AS track_id
FROM apex_collections
WHERE collection_name = alph_pkg_mountain.get_selected_tracks_collection_name
;
update alph_tracks set crypto_hash_typ1= null where crypto_hash_typ1 is null and gpx_data is not null
;
WITH agg AS (
    select trk.name_display, s.* 
            , bb_vert.x
            , bb_vert.y
            , min( x ) over ( partition by null ) min_x
            , max( x ) over ( partition by null ) max_x
            , min( y ) over ( partition by null ) min_y
            , max( y ) over ( partition by null ) max_y
            , avg( x ) over ( partition by null ) mid_x
            , avg( y ) over ( partition by null ) mid_y
    from v_alph_selected_tracks s
    JOIN -- should be in der view !
      v_alph_tracks trk ON trk.id = s.track_id 
    CROSS JOIN TABLE( sdo_util.getVertices ( sdo_geom.sdo_Mbr /*bounding only requires 2 geo points*/ ( trK.sdo_geo ) ) ) bb_vert
), dist AS (
SELECT DISTINCT 
    mid_x 
    , mid_y 
    , max_x - min_x AS x_delta
    , max_y - min_y AS y_delta
    , max_x, max_y
    , min_x, min_y
    , 9 AS zoom_level
FROM agg )
SELECT * FROM dist
;
SELECT * 
fROM table ( WORLD_TILES_N_BY_M )
;
CREATE TABLE temp_geo_json 
( sess_id NUMBER
 ,json_text clob 
 );
 alter table temp_geo_json add (layer_id NUMBER )
 ;
 alter table temp_geo_json add (insert_ts timestamp default systimestamp )
 ;
-- create a line from a polygone   
 SELECT
 sdo_util.to_geojson ( 
  SDO_UTIL.POLYGONTOLINE(
  SDO_GEOMETRY(
    2003,  -- two-dimensional polygon
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,1), -- one polygon (exterior polygon ring)
    SDO_ORDINATE_ARRAY(5,1, 8,1, 8,6, 5,7, 5,1)
  )
) 
) as geo_json
FROM DUAL;

SELECT * FROM temp_geo_json
;
SELECT * FROM alph_major_locations
;
-- from map_mountains source query
WITH center AS (
    SELECT id
    , l.latitude, l.longitude
        , to_number( :P5_RADIUS_FROM_LOC DEFAULT NULL ON CONVERSION ERROR ) / 100 
            + l.latitude AS north_most 
        , l.latitude  - to_number( :P5_RADIUS_FROM_LOC DEFAULT NULL ON CONVERSION ERROR ) / 100 
                AS south_most 
        , l.longitude - to_number( :P5_RADIUS_FROM_LOC DEFAULT NULL ON CONVERSION ERROR ) / 100 
                AS west_most 
        , to_number( :P5_RADIUS_FROM_LOC DEFAULT NULL ON CONVERSION ERROR ) / 100 
            + l.longitude AS east_most 
    FROM vp_alph_major_locations l 
    WHERE l.id = :P5_MAJOR_LOCATION 
 ), main AS 
 (
 SELECT name_display, longitude, latitude, altitude
    , name_normed||' '||altitude||'m' AS tool_tip
FROM alph_mountain m
WHERE 1=1
  AND ( :P5_MAX_MOUNTAINS IS NULL OR rownum <= to_number( :P5_MAX_MOUNTAINS) ) 
  AND ( :P5_MIN_ALTI IS NULL OR altitude >= to_number( :P5_MIN_ALTI ) )
  AND ( :P5_MAX_ALTI IS NULL OR altitude <= to_number( :P5_MAX_ALTI ) )  
  AND ( :P5_MAJOR_LOCATION IS NULL OR 
            latitude <= to_number( :P5_MAX_ALTI ) 
      )  
  AND ( :P5_MAJOR_LOCATION IS NULL OR 
           ( 1=1 
                AND latitude <= (SELECT north_most FROM center )
                AND latitude >= (SELECT south_most FROM center )
                AND longitude >= (SELECT west_most FROM center )
                AND longitude <= (SELECT east_most FROM center )
           )
      )  
 )     
SELECT * from main
;
select * from alph_major_locations 