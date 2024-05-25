CREATE OR REPLACE FUNCTION get_km_distance_of_loc_pair
( p_x_a NUMBER
 ,p_y_a NUMBER
 ,p_x_b NUMBER
 ,p_y_b NUMBER
) RETURN NUMBER 
AS 
/*
*/ 
	l_ret NUMBER;
BEGIN 
	IF 		abs( p_x_a ) >= 90 
		OR 	abs( p_y_a ) >= 90 
		OR 	abs( p_x_b ) >= 90 
		OR 	abs( p_y_b ) >= 90 
	THEN 
		raise_application_error( -20001, 'one of the coordinate exceeds ABS(90)!');
	END IF; 

	select sdo_geom.sdo_distance(
   sdo_geometry(2001,4326,null,sdo_elem_info_array(1, 1, 1),
                 sdo_ordinate_array(p_x_a, p_y_a )),
   sdo_geometry(2001,4326, null,sdo_elem_info_array(1, 1,1),
                 sdo_ordinate_array( p_x_b, p_y_b ))
	   ,1
	   ,'unit=KM') distance_km 
	INTO l_ret
	from dual
	;
	RETURN l_ret;
END;
/
show errors 