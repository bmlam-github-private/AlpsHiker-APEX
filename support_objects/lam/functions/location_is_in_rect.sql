CREATE OR REPLACE FUNCTION location_is_in_rect
( loc_lon NUMBER 
 ,loc_lat NUMBER 
 ,rect_a_lon NUMBER 
 ,rect_a_lat NUMBER 
 ,rect_b_lon NUMBER 
 ,rect_b_lat NUMBER 
) RETURN simple_integer
AS
/* the points A and B form the diagonal line of the rectangle. Return values based on the 
* relation between the given location and the rectangle:
* 0: location is outside 
* 1: location is on the border 
* 2: location is within 

* We normalize the rectangle by calculating the vector T and apply it to both A and B. One of this point will be the center
* , the other point gives the side length of the rectangle. We then also transpose the location using vector T. We then 
* simply compare it with the side length 

* Test cases:
	permutate location among -2, -1, 0, 1, 2
	permutate a and b among -1, 0, 1
*/
	l_ret simple_integer := 0; 		
	l_transpose_x NUMBER;
	l_transpose_y NUMBER;
	l_side_len_x NUMBER;
	l_side_len_y NUMBER;
	l_a_lon_tr		NUMBER;
	l_a_lat_tr		NUMBER;
	l_b_lon_tr		NUMBER;
	l_b_lat_tr		NUMBER;
BEGIN 
	l_transpose_x := least( rect_a_lon, rect_b_lon);
	l_transpose_y := least( rect_a_lat, rect_b_lat);

	l_a_lon_tr := rect_a_lon + l_transpose_x;
	l_a_lat_tr := rect_a_lat + l_transpose_y;

	l_b_lon_tr := rect_b_lon + l_transpose_x;
	l_b_lat_tr := rect_b_lat + l_transpose_y;

	IF l_a_lon_tr = 0 AND l_a_lat_tr = 0 
	THEN 
		l_side_len_x := l_b_lon_tr; l_side_len_y := l_b_lat_tr;
	ELSE 
		l_side_len_x := l_a_lon_tr; l_side_len_y := l_a_lat_tr;
	END IF; 

	l_ret :=
		CASE  
		WHEN 	loc_lon + l_transpose_x > l_side_len_x
			OR 	loc_lat + l_transpose_y > l_side_len_y
		THEN 0 
		WHEN 	loc_lon + l_transpose_x = l_side_len_x
			OR 	loc_lat + l_transpose_y = l_side_len_y
		THEN 1
		ELSE 0 
		END;

	RETURN l_ret;
END;
/
show errors
