rem this method is not a good idea as there are too much efforts to validate the resut 

set heading off pages 999 lines 200 trimspool on 

prompt set echo on 
prompt col result format 99

-- it is probably valid to only permute the location and always use the same square around the center point!
WITH base_vals AS (
	SELECT -2 AS val FROM dual UNION ALL 
	SELECT -1 AS val FROM dual UNION ALL 
	SELECT  0 AS val FROM dual UNION ALL 
	SELECT  1 AS val FROM dual UNION ALL 
	SELECT +3 AS val FROM dual 
), loc_perm AS ( 
	SELECT x.val AS loc_x , y.val AS loc_y 
	FROM base_vals x
	CROSS JOIN base_vals y 
)
SELECT 'SELECT location_is_in_rect( loc_lon=>'||loc_y||', loc_lat=>'||loc_x||', rect_a_lon=> -1, rect_a_lat=> -1, rect_b_lon=> 1, rect_b_lat=> 1 ) AS result FROM dual;'
  AS sql  
FROM loc_perm 
;