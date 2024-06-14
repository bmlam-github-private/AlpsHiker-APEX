CREATE OR REPLACE FUNCTION world_tiles_n_by_m
( p_horizonal_tiles 	SIMPLE_INTEGER DEFAULT 16
 ,p_vertical_tiles 		SIMPLE_INTEGER DEFAULT 16
)
RETURN location_col
AS 
/* suppose we divide the world map into m by n tiles, this function shall 
return the center location of each tile, along with a tooltip text. For  
simplicity, this text is just a sequential number of the tiles. The idea
is that user can use this number to quickly center on a region of the map  

python code: 
	# Define step sizes
	delta_lambda = 360 / m
	delta_phi = 180 / n

	# Generate center points for all tiles
	center_points = []

	for i in range(16):
	    for j in range(16):
	        lambda_center = -180 + (j + 0.5) * delta_lambda
	        phi_center = -90 + (i + 0.5) * delta_phi
	        center_points.append((phi_center, lambda_center))

*/
	c_delta_hor CONSTANT NUMBER := 360 / p_horizonal_tiles;
	c_delta_ver CONSTANT NUMBER := 180 / p_vertical_tiles;
	l_return location_col := location_col();
	v_loc	location_type;
BEGIN 
	FOR v IN 1 .. p_vertical_tiles 
	LOOP 
		FOR h IN 1 .. p_horizonal_tiles  
		LOOP 
			l_return.extend;
			l_return( l_return.count )
				:= location_type
						(latitude 	=> -90  + ( v + 0.5 ) * c_delta_ver
						,longitude	=> -180 + ( h + 0.5 ) * c_delta_hor
						,tool_tip	=> to_char( (v - 1) * p_vertical_tiles + h ) 
						);
		END LOOP; 
	END LOOP; 
	RETURN l_return;
END ;
/

show errors 
