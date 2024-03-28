CREATE OR REPLACE VIEW v_alph_selected_tracks 
AS
SELECT seq_id
	, n001 AS track_id
FROM apex_collections
WHERE collection_name = alph_pkg_mountain.get_selected_tracks_collection_name
;
