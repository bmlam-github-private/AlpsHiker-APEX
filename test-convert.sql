rem conversion code from ChatGpt 
set serveroutput on 








DECLARE
   -- Define variables to store the GPX input and GeoJSON output
   l_gpx_xml       XMLTYPE; -- Assuming GPX data is stored as XML
   l_geojson       CLOB := '{"type": "FeatureCollection", "features": [' || CHR(10);
   l_feature       CLOB;
   l_first_point   BOOLEAN := TRUE;
BEGIN
   -- Example GPX input (replace this with your actual GPX XML input)
   l_gpx_xml := XMLTYPE('
<?xml version="1.0" encoding="UTF-8"?>
<gpx xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" creator="bergfex GmbH" 
version="1.1" xsi:schemaLocation="https://www.topografix.com/GPX/1/1 https://www.topografix.com/GPX/1/1/gpx.xsd">
<metadata>
    <link href="https://www.bergfex.at">
    <text>bergfex GmbH</text>
    </link>
    </metadata>
    <trk><name>Der Bastione und Santa Barbara, die Herrschaften von Riva del Garda</name>
    <trkseg><trkpt lat="45.887006" lon="10.837854"><ele>88.0</ele></trkpt><trkpt lat="45.886979" lon="10.837772"><ele>88.0</ele></trkpt>
    <trkpt lat="45.886569" lon="10.837668"><ele>88.0</ele></trkpt><trkpt lat="45.886501" lon="10.837453"><ele>92.0</ele></trkpt>
    <trkpt lat="45.88641" lon="10.837396"><ele>94.0</ele></trkpt><trkpt lat="45.886019" lon="10.837358"><ele>95.0</ele></trkpt>
    <trkpt lat="45.885956" lon="10.837232"><ele>101.0</ele></trkpt><trkpt lat="45.886063" lon="10.837132"><ele>105.0</ele></trkpt>
    <trkpt lat="45.88611" lon="10.83697"><ele>113.0</ele></trkpt><trkpt lat="45.886229" lon="10.836961"><ele>112.0</ele></trkpt>
    <trkpt lat="45.88624" lon="10.836769"><ele>122.0</ele></trkpt><trkpt lat="45.886321" lon="10.83676"><ele>121.0</ele></trkpt>
    <trkpt lat="45.88634" lon="10.836641"><ele>127.0</ele></trkpt><trkpt lat="45.886547" lon="10.836398"><ele>137.0</ele></trkpt>
    <trkpt lat="45.886852" lon="10.836181"><ele>147.0</ele></trkpt><trkpt lat="45.886655" lon="10.836161"><ele>149.0</ele></trkpt>
    <trkpt lat="45.88697" lon="10.836035"><ele>154.0</ele></trkpt><trkpt lat="45.886975" lon="10.835991"><ele>157.0</ele></trkpt>
    <trkpt lat="45.886667" lon="10.836028"><ele>157.0</ele></trkpt><trkpt lat="45.886534" lon="10.835967"><ele>162.0</ele></trkpt>
    <trkpt lat="45.88676" lon="10.835847"><ele>167.0</ele></trkpt><trkpt lat="45.88633" lon="10.835808"><ele>175.0</ele></trkpt>
    <trkpt lat="45.886298" lon="10.835774"><ele>178.0</ele></trkpt><trkpt lat="45.886415" lon="10.835684"><ele>181.0</ele></trkpt>
    <trkpt lat="45.886228" lon="10.835672"><ele>185.0</ele></trkpt><trkpt lat="45.886349" lon="10.835601"><ele>187.0</ele></trkpt>
    <trkpt lat="45.885965" lon="10.835472"><ele>199.0</ele></trkpt><trkpt lat="45.886157" lon="10.835398"><ele>200.0</ele></trkpt><trkpt lat="45.885971" lon="10.835307"><ele>206.0</ele></trkpt><trkpt lat="45.886244" lon="10.835215"><ele>209.0</ele></trkpt><trkpt lat="45.88622" lon="10.835171"><ele>212.0</ele></trkpt>
    <trkpt lat="45.88557" lon="10.83505"><ele>225.0</ele></trkpt><trkpt lat="45.885307" lon="10.835279"><ele>222.0</ele></trkpt><trkpt lat="45.885128" lon="10.835545"><ele>218.0</ele></trkpt><trkpt lat="45.884934" lon="10.835694"><ele>215.0</ele></trkpt><trkpt lat="45.884752" lon="10.835699"><ele>217.0</ele></trkpt>
    <trkpt lat="45.884627" lon="10.83495"><ele>251.0</ele></trkpt><trkpt lat="45.884453" lon="10.834894"><ele>257.0</ele></trkpt><trkpt lat="45.884282" lon="10.834738"><ele>267.0</ele></trkpt><trkpt lat="45.884076" lon="10.834687"><ele>272.0</ele></trkpt><trkpt lat="45.883896" lon="10.834507"><ele>283.0</ele></trkpt>
    <trkpt lat="45.883996" lon="10.834417"><ele>288.0</ele></trkpt><trkpt lat="45.884129" lon="10.834474"><ele>284.0</ele></trkpt><trkpt lat="45.884501" lon="10.834183"><ele>301.0</ele></trkpt><trkpt lat="45.883918" lon="10.8338"><ele>319.0</ele></trkpt><trkpt lat="45.883816" lon="10.833863"><ele>317.0</ele></trkpt>
    <trkpt lat="45.883676" lon="10.833757"><ele>324.0</ele></trkpt><trkpt lat="45.883336" lon="10.833787"><ele>324.0</ele></trkpt><trkpt lat="45.883151" lon="10.833708"><ele>323.0</ele></trkpt><trkpt lat="45.883442" lon="10.833459"><ele>342.0</ele></trkpt><trkpt lat="45.883395" lon="10.833359"><ele>346.0</ele></trkpt>
    <trkpt lat="45.882993" lon="10.83343"><ele>323.0</ele></trkpt><trkpt lat="45.882791" lon="10.833306"><ele>314.0</ele></trkpt><trkpt lat="45.882436" lon="10.833575"><ele>303.0</ele></trkpt><trkpt lat="45.882019" lon="10.833723"><ele>347.0</ele></trkpt><trkpt lat="45.882361" lon="10.833195"><ele>323.0</ele></trkpt>
    <trkpt lat="45.882664" lon="10.83245"><ele>392.0</ele></trkpt><trkpt lat="45.882825" lon="10.832461"><ele>382.0</ele></trkpt><trkpt lat="45.883149" lon="10.832345"><ele>377.0</ele></trkpt><trkpt lat="45.883279" lon="10.832235"><ele>384.0</ele></trkpt><trkpt lat="45.883609" lon="10.832195"><ele>392.0</ele></trkpt>
    <trkpt lat="45.883669" lon="10.832105"><ele>403.0</ele></trkpt><trkpt lat="45.883569" lon="10.832115"><ele>399.0</ele></trkpt><trkpt lat="45.883449" lon="10.832005"><ele>409.0</ele></trkpt><trkpt lat="45.883149" lon="10.832015"><ele>410.0</ele></trkpt><trkpt lat="45.883099" lon="10.831985"><ele>414.0</ele></trkpt>
    <trkpt lat="45.883149" lon="10.831925"><ele>419.0</ele></trkpt><trkpt lat="45.883439" lon="10.831825"><ele>428.0</ele></trkpt><trkpt lat="45.883936" lon="10.831923"><ele>427.0</ele></trkpt><trkpt lat="45.884123" lon="10.831822"><ele>437.0</ele></trkpt><trkpt lat="45.88432" lon="10.831838"><ele>439.0</ele></trkpt>
    <trkpt lat="45.88438" lon="10.831728"><ele>447.0</ele></trkpt><trkpt lat="45.884625" lon="10.831847"><ele>444.0</ele></trkpt><trkpt lat="45.884944" lon="10.831734"><ele>454.0</ele></trkpt><trkpt lat="45.88444" lon="10.831258"><ele>479.0</ele></trkpt><trkpt lat="45.884827" lon="10.831226"><ele>486.0</ele></trkpt>
    <trkpt lat="45.88458" lon="10.831008"><ele>496.0</ele></trkpt><trkpt lat="45.88459" lon="10.830958"><ele>500.0</ele></trkpt><trkpt lat="45.88517" lon="10.831058"><ele>500.0</ele></trkpt><trkpt lat="45.88463" lon="10.830648"><ele>525.0</ele></trkpt><trkpt lat="45.884456" lon="10.8306"><ele>528.0</ele></trkpt><trkpt lat="45.885118" lon="10.830452"><ele>545.0</ele></trkpt>
    <trkpt lat="45.88476" lon="10.830108"><ele>573.0</ele></trkpt><trkpt lat="45.884532" lon="10.830254"><ele>562.0</ele></trkpt><trkpt lat="45.884228" lon="10.830267"><ele>560.0</ele></trkpt><trkpt lat="45.88375" lon="10.829928"><ele>575.0</ele></trkpt><trkpt lat="45.88362" lon="10.829638"><ele>587.0</ele></trkpt>
    <trkpt lat="45.88371" lon="10.829598"><ele>589.0</ele></trkpt><trkpt lat="45.88359" lon="10.829468"><ele>595.0</ele></trkpt><trkpt lat="45.88316" lon="10.829438"><ele>602.0</ele></trkpt><trkpt lat="45.88298" lon="10.829338"><ele>613.0</ele></trkpt><trkpt lat="45.882894" lon="10.829197"><ele>626.0</ele></trkpt>
    <trkpt lat="45.88265" lon="10.829238"><ele>630.0</ele></trkpt><trkpt lat="45.882472" lon="10.829358"><ele>627.0</ele></trkpt><trkpt lat="45.882316" lon="10.82964"><ele>613.0</ele></trkpt><trkpt lat="45.882306" lon="10.829395"><ele>632.0</ele></trkpt><trkpt lat="45.882062" lon="10.829734"><ele>619.0</ele></trkpt>
</trkseg>
</trk></gpx>
      ');
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
--
      l_feature := '  { "type": "Feature", "geometry": { "type": "Point", "coordinates": [' ||
                    trkpt_rec.lon || ', ' || trkpt_rec.lat || 
                    CASE WHEN trkpt_rec.elevation IS NOT NULL THEN  ', ' || trkpt_rec.elevation END || 
                    '] }, "properties": {} }';
--      
      l_geojson := l_geojson || l_feature;
   END LOOP;
--
   -- Close the GeoJSON array and the FeatureCollection
   l_geojson := l_geojson || CHR(10) || ']}';
   -- Output the resulting GeoJSON
   DBMS_OUTPUT.PUT_LINE(l_geojson);
END;
/

REM THIS example works
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
