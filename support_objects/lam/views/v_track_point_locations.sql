CREATE OR REPLACE VIEW v_track_point_locations  
AS 
/*
with get_gpx AS (
    select 
    	  id AS track_id
    	, extract_child_gpx_from_xml( gpx_data ) content 
    from alph_tracks tr
--    where id = 45
), add_seq AS (
		SELECT X.*
        , rownum as seq
        , track_id 
        FROM get_gpx g
        CROSS JOIN 
            xmlTable (
		    '//trk/trkseg/trkpt'
		    PASSING xmltype (
                g.content )
		    COLUMNS 
		         lon VARCHAR2(10) PATH '@lon'
		        ,lat VARCHAR2(10) PATH '@lat'
		        ,ele VARCHar2(10) PATH 'ele'
		        ,id  NUMBER(20) PATH 'id'
		)  X
), add_next_loc AS (
    SELECT aseq.*
    , lag ( lon ) over (partition by null order by seq ) next_lon 
    , lag ( lat ) over (partition by null order by seq ) next_lat 
    FROM add_seq aseq
)
SELECT anl.* 
        ,  SDO_GEOM.SDO_DISTANCE(
             SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(anl.lon, anl.lat, NULL), NULL, NULL)
           , SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(anl.next_lon, anl.next_lat, NULL), NULL, NULL)
           , 0.005
       ) AS distance_in_meters
FROM add_next_loc anl
WHERE next_lat IS NOT NULL 
*/ 
WITH get_gpx AS (
	SELECT tr.id AS track_id 
		, x.* 
	FROM alph_tracks tr 
	CROSS JOIN 
		  xmlTable (
			    '//trk/trkseg/trkpt'
			    PASSING xmltype (
	                extract_child_gpx_from_xml( gpx_data ))
			    COLUMNS 
			         lon VARCHAR2(10) PATH '@lon'
			        ,lat VARCHAR2(10) PATH '@lat'
			        ,ele VARCHar2(10) PATH 'ele'
			        --,id  NUMBER(20) PATH 'id'
			) x
)
, add_seq AS (
		SELECT g.*
        , row_number() OVER ( PARTITION BY track_id  ORDER BY NULL ) as seq
        FROM get_gpx g
) 
, add_next_loc AS (
    SELECT aseq.*
    , lag ( lon ) over (partition by track_id order by seq ) next_lon 
    , lag ( lat ) over (partition by track_id order by seq ) next_lat 
    FROM add_seq aseq
)
/*
SELECT anl.* 
        ,  SDO_GEOM.SDO_DISTANCE(
             SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(anl.lon, anl.lat, NULL), NULL, NULL)
           , SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(anl.next_lon, anl.next_lat, NULL), NULL, NULL)
           , 0.005
       ) AS distance_in_meters
FROM add_next_loc anl
WHERE next_lat IS NOT NULL 
*/
SELECT * FROM add_next_loc   
;
