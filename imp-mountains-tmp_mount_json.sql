DECLARE	 
	v_loop_cnt NUMBER :=0;
	v_ins_cnt NUMBER :=0;
	v_upd_cnt NUMBER :=0;
	v_mount_id_curr NUMBER;
    v_remark_curr   alph_mountain."REMARKS"%TYPE;
BEGIN 
	pck_std_log.inf( 'Start processing of tmp mountains extracted from OSM');
	FOR r_tmp IN ( 
		SELECT name, osm_id AS osm_node_id
			, ele, lat, lon
		FROM tmp_mountains_json 
		ORDER BY name 
	) LOOP 
		SELECT max(id)
		INTO v_mount_id_curr
		FROM alph_mountain pm 
		WHERE round( r_tmp.lat) = round (pm.latitude )
		  AND round( r_tmp.lon) = round (pm.longitude )
		  AND substr( r_tmp.name, 1, 3 ) = substr( pm.name_display, 1, 3 ) 
		;
		IF v_mount_id_curr IS NOT NULL 
		THEN
			SELECT "REMARKS" INTO v_remark_curr
			FROM alph_mountain
			WHERE id = v_mount_id_curr
			;
		  	IF instr( nvl(v_remark_curr, '?'), 'OSM_node_id' ) = 0 
			THEN 
				UPDATE alph_mountain z
				SET remarks = z.remarks||'. OSM_node_id '||r_tmp.osm_node_id
					||CASE WHEN z.name_display <> r_tmp.name THEN ', name: '||r_tmp.name END 
				WHERE id = v_mount_id_curr
				;
				v_upd_cnt := v_upd_cnt + 1;
			ELSE
				pck_std_log.inf( 'Mount id '||v_mount_id_curr||' already updated?' );
			END IF;
		ELSE	 
            BEGIN 
                INSERT INTO alph_mountain
                ( name_display, altitude, latitude, longitude
                , remarks 
                ) VALUES	 
                ( r_tmp.name, r_tmp.ele, r_tmp.lat, r_tmp.lon
                 , 'OSM node id '||r_tmp.osm_node_id
                );
                v_ins_cnt := v_ins_cnt + 1;
            EXCEPTION 
                WHEN dup_val_on_index THEN 
                    pck_std_log.inf( 'OSM node id '||r_tmp.osm_node_id ||' with name '||r_tmp.name||' violates unique constraint' );
            END;
		END IF;
	END LOOP;
	pck_std_log.inf ( 'Mountains inserted from tmp_moutainss_json: '||v_ins_cnt
		||', updated: '||v_upd_cnt ||'. loop passes: '||v_loop_cnt 
		);
	COMMIT;
END;
/
