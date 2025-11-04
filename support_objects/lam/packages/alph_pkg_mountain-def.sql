create or replace package alph_pkg_mountain 
as
	--c_selected_tracks_appl_item_name 		CONSTANT VARCHAR2(100) := 'SELECTED_TRACKS_COl_V_KEY';
	--c_selected_tracks_appl_item_value 	CONSTANT VARCHAR2(100) := 'SELECTED_TRACKS_COLLECTION';
	c_selected_tracks_collection_name 	CONSTANT VARCHAR2(100) := 'SELECTED_TRACKS_COLLECTION';
	 

	procedure import_mountain_csv (
		p_csv_content varchar2
		,p_ignore_csv BOOLEAN DEFAULT FALSE
	) ;

    procedure update_location_with_csv (
        p_csv_content_no_header varchar2
        ,p_ignore_csv BOOLEAN DEFAULT FALSE
    ) ;
    
    procedure merge_mountain_from_imp;
	/* Suppose we have imported a GPX as BLOB into the table TEMP_BLOB and want extract 
	* various attributes of this track. 
	*/
	PROCEDURE extract_track_info ( 
	     pi_blob_id   IN    NUMBER 
	    ,po_info_json OUT   VARCHAR2 
	) ; 

	PROCEDURE init_application_items;

	PROCEDURE switch_track_selection_status 
	( p_track_id  	NUMBER 
	, p_on 			BOOLEAN 
	);

	PROCEDURE mark_selected_tracks 
	( p_data VARCHAR2 
	 ,p_replace_current_selected BOOLEAN DEFAULT FALSE   
	 ,p_input_format VARCHAR2 DEFAULT 'BLANK_SEPARATED'
	);
	FUNCTION get_selected_tracks_collection_name 
	RETURN VARCHAR2 
	;

	FUNCTION get_landmarks_around_location
	( pi_min_alti NUMBER 
	, pi_max_alti NUMBER 
	, pi_location_id  NUMBER 
	, pi_offset_centi_degree  NUMBER 
	, pi_max_matches NUMBER 
	) RETURN landmark_col
	;
	FUNCTION get_landmarks_within_bounds
	( pi_min_alti NUMBER 
	, pi_max_alti NUMBER 
	, pi_east_most  NUMBER 
	, pi_south_most  NUMBER 
	, pi_west_most NUMBER 
	, pi_north_most NUMBER 
	, pi_max_matches NUMBER 
	) RETURN landmark_col
	;
	FUNCTION get_landmarks_around_location_json_sum 
	( pi_min_alti NUMBER 
	, pi_max_alti NUMBER 
	, pi_location_id  NUMBER 
	, pi_offset_centi_degree  NUMBER 
	, pi_max_matches NUMBER 
	) RETURN CLOB
	;
end;
/

show errors package specification 
