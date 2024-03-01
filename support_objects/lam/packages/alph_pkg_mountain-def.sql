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
	
end;
/

show errors package specification 
