start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/alph_pkg_mountain-impl.sql
;
start /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/packages/test-alph_pkg_mountain-mark_selected_tracks.sql "7 45 65"
;
sta /Users/bmlam/Documents/AlpsHiker-APEX/support_objects/lam/views/v_alph_selected_tracks.sql
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

select ' ' x
 , sdo_util.to_geojson( sdo_geo )  gj
--    , DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(gpx_data), 1 ) digest
    , dbms_lob.getlength( gpx_data ) len 
, tr.*
from alph_tracks tr
where 1=1
  AND id = 45 
  AND sdo_geo IS NOT NULL 
order by null 
-- lower(name_display) desc
;
desc alph_tracks
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
--and rownum <= 5
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
-- delete temp_geo_json
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
order by insert_ts desc
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
;
-- conversion code from ChatGpt 
DECLARE
   -- Define variables to store the GPX input and GeoJSON output
   l_gpx_xml       XMLTYPE; -- Assuming GPX data is stored as XML
   l_geojson       CLOB := '{"type": "FeatureCollection", "features": [' || CHR(10);
   l_feature       CLOB;
   l_first_point   BOOLEAN := TRUE;
BEGIN
   -- Example GPX input (replace this with your actual GPX XML input)
   l_gpx_xml := XMLTYPE('<?xml version="1.0" encoding="UTF-8"?>
      <gpx version="1.1" creator="Example">
         <trk>
            <name>Example Track</name>
            <trkseg>
               <trkpt lat="48.20849" lon="16.37208"><ele>160</ele><time>2024-11-10T12:00:00Z</time></trkpt>
               <trkpt lat="48.20850" lon="16.37210"><ele>162</ele><time>2024-11-10T12:01:00Z</time></trkpt>
               <trkpt lat="48.20851" lon="16.37212"><ele>165</ele><time>2024-11-10T12:02:00Z</time></trkpt>
            </trkseg>
         </trk>
      </gpx>');
   -- Iterate over each track point in the GPX
   FOR trkpt_rec IN (
      SELECT
         EXTRACTVALUE(VALUE(trkpt), '@lat') AS lat,
         EXTRACTVALUE(VALUE(trkpt), '@lon') AS lon,
         EXTRACTVALUE(VALUE(trkpt), 'ele') AS elevation
      FROM TABLE(
         XMLSEQUENCE(
            l_gpx_xml.EXTRACT('//gpx/trk/trkseg/trkpt')
         )
      ) trkpt
   ) LOOP
      -- Create a GeoJSON feature for each track point
      IF NOT l_first_point THEN
         l_geojson := l_geojson || ',' || CHR(10);
      ELSE
         l_first_point := FALSE;
      END IF;
      l_feature := '  { "type": "Feature", "geometry": { "type": "Point", "coordinates": [' ||
                    trkpt_rec.lon || ', ' || trkpt_rec.lat || 
--                    NVL2(trkpt_rec.elevation, ', ' || trkpt_rec.elevation, '') || 
                    '] }, "properties": {} }';
      l_geojson := l_geojson || l_feature;
   END LOOP;
   -- Close the GeoJSON array and the FeatureCollection
   l_geojson := l_geojson || CHR(10) || ']}';
   -- Output the resulting GeoJSON
   DBMS_OUTPUT.PUT_LINE(l_geojson);
END;
/

--- SQL test 

   -- Iterate over each track point in the GPX
      SELECT
         EXTRACTvalue(trkpt.column_value, '@lat') AS lat,
--         EXTRACTVALUE(VALUE(trkpt), '@lon') AS lon,
--         EXTRACTVALUE(VALUE(trkpt), 'ele') AS elevation
--         VALUE(trkpt).getClobVal val 
     trkpt.column_value.getClobVal() val
       FROM TABLE(
         XMLSEQUENCE(
            XMLTYPE('<?xml version="1.0" encoding="UTF-8"?>
      <gpx version="1.1" creator="Example">
         <trk>
            <name>Example Track</name>
            <trkseg>
               <trkpt lat="48.20849" lon="16.37208"><ele>160</ele><time>2024-11-10T12:00:00Z</time></trkpt>
               <trkpt lat="48.20850" lon="16.37210"><ele>162</ele><time>2024-11-10T12:01:00Z</time></trkpt>
               <trkpt lat="48.20851" lon="16.37212"><ele>165</ele><time>2024-11-10T12:02:00Z</time></trkpt>
            </trkseg>
         </trk>
      </gpx>').EXTRACT('//gpx/trk/trkseg/trkpt')
         )
      ) trkpt
      ;
      
select * from xmltable (
  'ivk/nperiods/nperiod'
  passing xmltype ( '<ivk>
  <insurance>
   <sumins>20596</sumins>
   <yearsins>56</yearsins>
   <daysins>156</daysins>
  </insurance>
 <nperiods>
  <nperiod datefrom="1965-10-03" dateto="1965-10-03" days="1" />
  <nperiod datefrom="2005-09-01" dateto="2009-12-31" days="1583" />
  <nperiod datefrom="2013-01-01" dateto="2013-12-31" days="8" />
 </nperiods>
</ivk>' )
  columns 
    datefrom varchar2(10) path '@datefrom',
    dateto varchar2(10) path '@dateto',
    days integer path '@days'
)
;
SELECT *
FROM xmlTable (
    '/gpx/trk/trkseg/trkpt'
    PASSING xmltype (
      '<gpx version="1.1" creator="Example">
         <trk>
            <name>Example Track</name>
            <trkseg>
               <trkpt lat="48.20849" lon="16.37208"><ele>160</ele><time>2024-11-10T12:00:00Z</time></trkpt>
               <trkpt lat="48.20850" lon="16.37210"><ele>162</ele><time>2024-11-10T12:01:00Z</time></trkpt>
               <trkpt lat="48.20851" lon="16.37212"><ele>165</ele><time>2024-11-10T12:02:00Z</time></trkpt>
            </trkseg>
         </trk>
      </gpx>'
    )
    COLUMNS 
         lon VARCHAR2(10) PATH '@lon'
        ,lat VARCHAR2(10) PATH '@lat'
        ,ele NUMBER(10,5) PATH 'ele'
)
;
--- working example to extract coordinates from overturbo output 
select gj.* , sess_id, insert_ts
from ( 
    SELECT * 
    FROM temp_geo_json tmp
    WHERE   1=1
     -- tmp.sess_id =  apex_custom_auth.get_session_id
      --AND layer_id = 1 
      AND sess_id = 6861802301585
 ) tmp 
CROSS JOIN  json_table (
  tmp.json_text ,           '$.elements[*]'
    columns ( 
            --js_val VARCHAR2(50) FORMAT JSON PATH '$'
              id number (38) PATH '$.id' 
            , lon number (9, 6) PATH '$.lon' 
            , lat number (9, 6) PATH '$.lat' 
            , place_name VARCHAR2(200 CHAR) PATH '$.tags.name' 
    )
) gj
