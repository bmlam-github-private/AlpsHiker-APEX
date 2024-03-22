REM APEX session environment must be set up first. there should be a separate script for this purpose

var v_collection_name VARCHAR2

exec :v_collection_name := alph_pkg_mountain.c_selected_tracks_collection_name;

prompt Expect exception since collection should not exist yet
begin
	alph_pkg_mountain.switch_track_selection_status( p_track_id=> 123, p_on => false );
end;
/


prompt Expect one row
begin
	alph_pkg_mountain.switch_track_selection_status( p_track_id=> 123, p_on => true );
end;
/

SELECT n001 FROM apex_collections WHERE collection_name = :v_collection_name
ORDER BY n001
;


prompt Expect one row, after adding the same track
begin
	alph_pkg_mountain.switch_track_selection_status( p_track_id=> 123, p_on => true );
end;
/

SELECT n001 FROM apex_collections WHERE collection_name = :v_collection_name
ORDER BY n001
;
set serveroutput on


prompt Expect zero row, after switching  off the  track
begin
	alph_pkg_mountain.switch_track_selection_status( p_track_id=> 123, p_on => false );
end;
/

SELECT n001 FROM apex_collections WHERE collection_name = :v_collection_name
ORDER BY n001
;

set serveroutput off
