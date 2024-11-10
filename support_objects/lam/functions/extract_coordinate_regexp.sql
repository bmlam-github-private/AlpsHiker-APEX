CREATE OR REPLACE FUNCTION extract_coordinate_regexp 
( coord_string VARCHAR 
 ,lati_or_longi VARCHAR2 
 ,decimal_point VARCHAR2 DEFAULT '.'
) RETURN VARCHAR2 
AS 
	v_abs_val VARCHAR2(10);
	v_direction VARCHAR2(10);
	v_ret VARCHAR2(10);
BEGIN 
	IF upper( lati_or_longi ) NOT IN ( 'LON', 'LAT' ) THEN
		RAISE_APPLICATION_ERROR ( -20001, 'must be LON or LAT, mixed case allowed');
	END IF;
	-- 
	with rstr AS (
		SELECT coord_string AS val
		FROM dual 
	), cleansed AS (
	SELECT regexp_replace ( val
	   , '.*?(\d{1,2}).*?(\d{1,2}).*?(\d{1,2}).(.*?)(\d{1,2}).*?(\d{1,2}).*?(\d{1,2}).(.*)$',
	    '\1 \2 \3 \4 \5 \6 \7 \8'
	    ) AS val 
	FROM rstr
	), struct AS (
	    SELECT REGEXP_SUBSTR( val, '[^ ]+', 1, LEVEL) part, level AS lev
	        ,val 
	    from  cleansed  
	    CONNECT BY REGEXP_SUBSTR( val, '[^ ]+', 1, LEVEL) IS NOT NULL
	)    , geo AS (
	SELECT
		max(  case when lev = 1 then ltrim(part, chr(10) ) end ) as lat_major -- first token has newline
		,max( case when lev = 2 then part end ) as lat_mins
		,max( case when lev = 3 then part end ) as lat_secs
		,max( case when lev = 4 then part end ) as n_or_s
		--
		,max( case when lev = 5 then part end ) as lon_major
		,max( case when lev = 6 then part end ) as lon_mins
		,max( case when lev = 7 then part end ) as lon_secs
		,max( case when lev = 8 then part end ) as e_or_w
	from struct
	), showable AS ( 
	SELECT 
	   round( to_number ( lat_major )
	    + to_number( lat_mins ) / 60 
	    + to_number( lat_secs ) / 60 / 60 
	    , 6 )
	    AS lati
	   , round( to_number ( lon_major )
	    + to_number( lon_mins ) / 60 
	    + to_number( lon_secs ) / 60 / 60 
	    , 6 )
	    AS longi
	,g.*
	FROM geo g 
	)
	SELECT 
		CASE 
		WHEN upper( lati_or_longi ) = 'LON' THEN longi 
		WHEN upper( lati_or_longi ) = 'LAT' THEN lati 
		END 
		,CASE 
		WHEN upper( lati_or_longi ) = 'LON' THEN e_or_w 
		WHEN upper( lati_or_longi ) = 'LAT' THEN n_or_s 
		END 
		INTO v_abs_val
			,v_direction
	FROM showable
	;
	v_abs_val :=  CASE WHEN decimal_point = '.' THEN replace ( v_abs_val, ',', '.' ) ELSE v_abs_val END ;

	v_ret := 
		CASE WHEN upper( v_direction ) IN ( 'S', 'W') THEN '-'||v_abs_val ELSE v_abs_val	END;
	RETURN v_ret; 
END;
/

SHOW ERRORS 

