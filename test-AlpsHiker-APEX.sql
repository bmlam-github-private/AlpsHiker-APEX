start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/alph_pkg_mountain-def.sql
;
sta /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/triggers/alph_tracks_compound.sql

sta /Users/bmlam/Library/CloudStorage/Dropbox/git_clones/mailto-git_clones/lam_personal/hotspots/improve_apex/test-apex_collections.sql

select * from log_table_v2
order by log_ts desc fetch first 100 rows only
;

select 
--sdo_util.to_geojson ( sdo_geo ) geojs,
t.* 
from alph_tracks t
order by ins_date desc
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



-- test code from trigger that caused error;
declare 
        v_temp RAW (32767);
        v_hash alph_tracks.crypto_hash_typ1%type;
BEGIN
    for rec in ( 
        select gpx_data
        from alph_tracks
        where gpx_data is not null 
    ) loop
            v_temp := DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(rec.gpx_data), 1 ) ;
          dbms_output.put ( 'Ln'||$$PLSQL_LINE|| ' len of v_temp: '|| length( v_temp ) );
          v_hash := substr( v_temp, 1, 100);
    end loop;
END;
/