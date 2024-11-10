-- oops , a join between major location and mountain is not possible!
CREATE OR REPLACE VIEW vp_alph_mountains 
AS
	id
	,name_display
	,name_normed
		GENERATED
	,altitude
	,longitude
	,latitude
	,mountain_group_id
	,remarks
FROM alph_mountains m
LEFT JOIN alph_major_locations l 

