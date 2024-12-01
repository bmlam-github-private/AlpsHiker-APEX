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
CREATE TABLE temp_geo_json 
( sess_id NUMBER
 ,json_text clob 
 );
 alter table temp_geo_json add (layer_id NUMBER )
 ;
 alter table temp_geo_json add (insert_ts timestamp default systimestamp )
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

rem conversion code from ChatGpt 

DECLARE
   -- Define variables to store the GPX input and GeoJSON output
   l_gpx_xml       XMLTYPE; -- Assuming GPX data is stored as XML
   l_geojson       CLOB := '{"type": "FeatureCollection", "features": [' || CHR(10);
   l_feature       CLOB;
   l_first_point   BOOLEAN := TRUE;
BEGIN
   -- Example GPX input (replace this with your actual GPX XML input)
   l_gpx_xml := XMLTYPE('
"<?xml version="1.0" encoding="UTF-8"?>
<gpx xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" creator="bergfex GmbH" version="1.1" xsi:schemaLocation="https://www.topografix.com/GPX/1/1 https://www.topografix.com/GPX/1/1/gpx.xsd"><metadata><link href="https://www.bergfex.at"><text>bergfex GmbH</text></link></metadata><trk><name>Der Bastione und Santa Barbara, die Herrschaften von Riva del Garda</name><trkseg><trkpt lat="45.887006" lon="10.837854"><ele>88.0</ele></trkpt><trkpt lat="45.886979" lon="10.837772"><ele>88.0</ele></trkpt><trkpt lat="45.886569" lon="10.837668"><ele>88.0</ele></trkpt><trkpt lat="45.886501" lon="10.837453"><ele>92.0</ele></trkpt><trkpt lat="45.88641" lon="10.837396"><ele>94.0</ele></trkpt><trkpt lat="45.886019" lon="10.837358"><ele>95.0</ele></trkpt><trkpt lat="45.885956" lon="10.837232"><ele>101.0</ele></trkpt><trkpt lat="45.886063" lon="10.837132"><ele>105.0</ele></trkpt><trkpt lat="45.88611" lon="10.83697"><ele>113.0</ele></trkpt><trkpt lat="45.886229" lon="10.836961"><ele>112.0</ele></trkpt><trkpt lat="45.88624" lon="10.836769"><ele>122.0</ele></trkpt><trkpt lat="45.886321" lon="10.83676"><ele>121.0</ele></trkpt><trkpt lat="45.88634" lon="10.836641"><ele>127.0</ele></trkpt><trkpt lat="45.886547" lon="10.836398"><ele>137.0</ele></trkpt><trkpt lat="45.886852" lon="10.836181"><ele>147.0</ele></trkpt><trkpt lat="45.886655" lon="10.836161"><ele>149.0</ele></trkpt><trkpt lat="45.88697" lon="10.836035"><ele>154.0</ele></trkpt><trkpt lat="45.886975" lon="10.835991"><ele>157.0</ele></trkpt><trkpt lat="45.886667" lon="10.836028"><ele>157.0</ele></trkpt><trkpt lat="45.886534" lon="10.835967"><ele>162.0</ele></trkpt><trkpt lat="45.88676" lon="10.835847"><ele>167.0</ele></trkpt><trkpt lat="45.88633" lon="10.835808"><ele>175.0</ele></trkpt><trkpt lat="45.886298" lon="10.835774"><ele>178.0</ele></trkpt><trkpt lat="45.886415" lon="10.835684"><ele>181.0</ele></trkpt><trkpt lat="45.886228" lon="10.835672"><ele>185.0</ele></trkpt><trkpt lat="45.886349" lon="10.835601"><ele>187.0</ele></trkpt><trkpt lat="45.885965" lon="10.835472"><ele>199.0</ele></trkpt><trkpt lat="45.886157" lon="10.835398"><ele>200.0</ele></trkpt><trkpt lat="45.885971" lon="10.835307"><ele>206.0</ele></trkpt><trkpt lat="45.886244" lon="10.835215"><ele>209.0</ele></trkpt><trkpt lat="45.88622" lon="10.835171"><ele>212.0</ele></trkpt><trkpt lat="45.88557" lon="10.83505"><ele>225.0</ele></trkpt><trkpt lat="45.885307" lon="10.835279"><ele>222.0</ele></trkpt><trkpt lat="45.885128" lon="10.835545"><ele>218.0</ele></trkpt><trkpt lat="45.884934" lon="10.835694"><ele>215.0</ele></trkpt><trkpt lat="45.884752" lon="10.835699"><ele>217.0</ele></trkpt><trkpt lat="45.884627" lon="10.83495"><ele>251.0</ele></trkpt><trkpt lat="45.884453" lon="10.834894"><ele>257.0</ele></trkpt><trkpt lat="45.884282" lon="10.834738"><ele>267.0</ele></trkpt><trkpt lat="45.884076" lon="10.834687"><ele>272.0</ele></trkpt><trkpt lat="45.883896" lon="10.834507"><ele>283.0</ele></trkpt><trkpt lat="45.883996" lon="10.834417"><ele>288.0</ele></trkpt><trkpt lat="45.884129" lon="10.834474"><ele>284.0</ele></trkpt><trkpt lat="45.884501" lon="10.834183"><ele>301.0</ele></trkpt><trkpt lat="45.883918" lon="10.8338"><ele>319.0</ele></trkpt><trkpt lat="45.883816" lon="10.833863"><ele>317.0</ele></trkpt><trkpt lat="45.883676" lon="10.833757"><ele>324.0</ele></trkpt><trkpt lat="45.883336" lon="10.833787"><ele>324.0</ele></trkpt><trkpt lat="45.883151" lon="10.833708"><ele>323.0</ele></trkpt><trkpt lat="45.883442" lon="10.833459"><ele>342.0</ele></trkpt><trkpt lat="45.883395" lon="10.833359"><ele>346.0</ele></trkpt><trkpt lat="45.882993" lon="10.83343"><ele>323.0</ele></trkpt><trkpt lat="45.882791" lon="10.833306"><ele>314.0</ele></trkpt><trkpt lat="45.882436" lon="10.833575"><ele>303.0</ele></trkpt><trkpt lat="45.882019" lon="10.833723"><ele>347.0</ele></trkpt><trkpt lat="45.882361" lon="10.833195"><ele>323.0</ele></trkpt><trkpt lat="45.882664" lon="10.83245"><ele>392.0</ele></trkpt><trkpt lat="45.882825" lon="10.832461"><ele>382.0</ele></trkpt><trkpt lat="45.883149" lon="10.832345"><ele>377.0</ele></trkpt><trkpt lat="45.883279" lon="10.832235"><ele>384.0</ele></trkpt><trkpt lat="45.883609" lon="10.832195"><ele>392.0</ele></trkpt><trkpt lat="45.883669" lon="10.832105"><ele>403.0</ele></trkpt><trkpt lat="45.883569" lon="10.832115"><ele>399.0</ele></trkpt><trkpt lat="45.883449" lon="10.832005"><ele>409.0</ele></trkpt><trkpt lat="45.883149" lon="10.832015"><ele>410.0</ele></trkpt><trkpt lat="45.883099" lon="10.831985"><ele>414.0</ele></trkpt><trkpt lat="45.883149" lon="10.831925"><ele>419.0</ele></trkpt><trkpt lat="45.883439" lon="10.831825"><ele>428.0</ele></trkpt><trkpt lat="45.883936" lon="10.831923"><ele>427.0</ele></trkpt><trkpt lat="45.884123" lon="10.831822"><ele>437.0</ele></trkpt><trkpt lat="45.88432" lon="10.831838"><ele>439.0</ele></trkpt><trkpt lat="45.88438" lon="10.831728"><ele>447.0</ele></trkpt><trkpt lat="45.884625" lon="10.831847"><ele>444.0</ele></trkpt><trkpt lat="45.884944" lon="10.831734"><ele>454.0</ele></trkpt><trkpt lat="45.88444" lon="10.831258"><ele>479.0</ele></trkpt><trkpt lat="45.884827" lon="10.831226"><ele>486.0</ele></trkpt><trkpt lat="45.88458" lon="10.831008"><ele>496.0</ele></trkpt><trkpt lat="45.88459" lon="10.830958"><ele>500.0</ele></trkpt><trkpt lat="45.88517" lon="10.831058"><ele>500.0</ele></trkpt><trkpt lat="45.88463" lon="10.830648"><ele>525.0</ele></trkpt><trkpt lat="45.884456" lon="10.8306"><ele>528.0</ele></trkpt><trkpt lat="45.885118" lon="10.830452"><ele>545.0</ele></trkpt><trkpt lat="45.88476" lon="10.830108"><ele>573.0</ele></trkpt><trkpt lat="45.884532" lon="10.830254"><ele>562.0</ele></trkpt><trkpt lat="45.884228" lon="10.830267"><ele>560.0</ele></trkpt><trkpt lat="45.88375" lon="10.829928"><ele>575.0</ele></trkpt><trkpt lat="45.88362" lon="10.829638"><ele>587.0</ele></trkpt><trkpt lat="45.88371" lon="10.829598"><ele>589.0</ele></trkpt><trkpt lat="45.88359" lon="10.829468"><ele>595.0</ele></trkpt><trkpt lat="45.88316" lon="10.829438"><ele>602.0</ele></trkpt><trkpt lat="45.88298" lon="10.829338"><ele>613.0</ele></trkpt><trkpt lat="45.882894" lon="10.829197"><ele>626.0</ele></trkpt><trkpt lat="45.88265" lon="10.829238"><ele>630.0</ele></trkpt><trkpt lat="45.882472" lon="10.829358"><ele>627.0</ele></trkpt><trkpt lat="45.882316" lon="10.82964"><ele>613.0</ele></trkpt><trkpt lat="45.882306" lon="10.829395"><ele>632.0</ele></trkpt><trkpt lat="45.882062" lon="10.829734"><ele>619.0</ele></trkpt></trkseg></trk></gpx>
"      ');
   -- Iterate over each track point in the GPX
   FOR trkpt_rec IN (
      SELECT
         EXTRACTVALUE(VALUE(trkpt), '@lat') AS lat,
         EXTRACTVALUE(VALUE(trkpt), '@lon') AS lon,
         EXTRACTVALUE(VALUE(trkpt), 'ele') AS elevation
      FROM TABLE(
         XMLSEQUENCE(
            l_gpx_xml.EXTRACT('//trkseg/trkpt')
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
                    NVL2(trkpt_rec.elevation, ', ' || trkpt_rec.elevation, '') || 
                    '] }, "properties": {} }';
      
      l_geojson := l_geojson || l_feature;
   END LOOP;

   -- Close the GeoJSON array and the FeatureCollection
   l_geojson := l_geojson || CHR(10) || ']}';

   -- Output the resulting GeoJSON
   DBMS_OUTPUT.PUT_LINE(l_geojson);
END;
/