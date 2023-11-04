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

end;
/

show errors
