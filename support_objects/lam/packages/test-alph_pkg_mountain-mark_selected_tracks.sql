DEF pi_track_csv=&1

rem example track ids: 103 102 65 21 7
REM APEX session environment must be set up first. there should be a separate script for this purpose. Parameters should be:  115 LAM

var v_collection_name VARCHAR2

exec :v_collection_name := alph_pkg_mountain.c_selected_tracks_collection_name;

prompt Expect exception since collection should not exist yet
begin
	alph_pkg_mountain.mark_selected_tracks
	( p_data =>  '&pi_track_csv'
     ,p_replace_current_selected => true  
    );
end;
/

set serveroutput ON 

EXEC dbms_output.put_line( ' tracks in collection: ' ||  apex_collection.collection_member_count( :v_collection_name) )

set serveroutput off
