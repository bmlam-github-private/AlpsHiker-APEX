CREATE OR REPLACE VIEW v_alph_selected_tracks_agg 
AS
/* Per https://wiki.openstreetmap.org/wiki/Zoom_levels, each zoom level corresponds to many longitudinal degree 
* or fraction thereof it shown on the map:
Level : degrees 	
	0	360
	1	180
	2	90
	3	45
	4	22.5
	5	11.25
	6	5.625
	7	2.813
	8	1.406
	9	.703
	10	.352
	11	.176
	12	.088
	13	.044
	14	.022
	15	.011
	16	.005
	17	.003
	18	.001
	19	0.0005
	20	0.00025
*/ 
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
FROM agg )
SELECT dist.*, 
  CASE 
  WHEN x_delta > 180 	THEN 0
  WHEN x_delta > 90 	THEN 1
  WHEN x_delta > 45 	THEN 2
  WHEN x_delta > 22 	THEN 3
  WHEN x_delta > 11 	THEN 4
  WHEN x_delta > 5 		THEN 5
  WHEN x_delta > 2 		THEN 6
  WHEN x_delta > 1 		THEN 7
  WHEN x_delta > .7 	THEN 8
  WHEN x_delta > .35	THEN 9
  WHEN x_delta > .17 	THEN 10
  WHEN x_delta > .08 	THEN 11
  WHEN x_delta > .04 	THEN 12
  WHEN x_delta > .02 	THEN 13
  WHEN x_delta > .01 	THEN 14
  WHEN x_delta > .005 	THEN 15
  WHEN x_delta > .002	THEN 16
  WHEN x_delta > .001 	THEN 17
  ELSE	 18
  END 
  AS zoom_level 
FROM dist
;
