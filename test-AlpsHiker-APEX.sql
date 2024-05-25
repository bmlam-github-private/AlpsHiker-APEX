start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/alph_pkg_mountain-impl.sql
;
sta /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/triggers/alph_tracks_compound.sql

sta /Users/bmlam/Library/CloudStorage/Dropbox/git_clones/mailto-git_clones/lam_personal/hotspots/improve_apex/test-apex_collections.sql

alter session set nls_date_format = 'yyyy.mm.dd hh24:mi:ss';
select * from log_table_v2
where 1=1
  AND caller_position not like 'procedure LAM.LOOP_CREATE_USER_REQS:%' 
order by log_ts desc fetch first 100 rows only
;
desc pck_std_log
;
SELECT tr.id, tr.name_display, tr.date_started, tr.sdo_geo, tr.remarks 
 , name_display||' started '||to_char( date_started , 'yyyy.mm.dd hh24:mi') AS tool_tip
, rownum AS layer_id 
, sdo_util.to_geojson ( sdo_geo ) geojs
--, sdo_util.from_geojson ( gpx_data ) sdo_geo
, gpx_data
FROM alph_tracks tr
--JOIN v_alph_selected_tracks sl ON sl.track_id = tr.id
WHERE 1=1
--  AND id = 82 
--  AND tr.sdo_geo IS NOT NULL 
and rownum <= 5
order by id desc 
;
update alph_tracks set date_started = null where crypto_hash_typ1 is null
;
select *
--    , DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(gpx_data), 1 ) digest
--    , dbms_lob.getlength( gpx_data ) len 
from alph_tracks
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
select * from all_tables where table_name like 'LOG_TA%'
;
select * from all_objects where object_name like 'LOG%IN%'
;
desc loginfo
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

desc alph_tracks
;
update alph_tracks set crypto_hash_typ1= null where crypto_hash_typ1 is null and gpx_data is not null
;
create or replace view v_alph_tracks as select * from alph_tracks where gpx_data is not null
;
