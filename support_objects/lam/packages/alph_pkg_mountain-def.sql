create or replace package alph_pkg_mountain as
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

end;
/

show errors
