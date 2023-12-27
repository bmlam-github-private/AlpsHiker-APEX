create table alph_tracks (
	 id number(10)                GENERATED ALWAYS AS IDENTITY PRIMARY KEY
	,name_display varchar2(100)            NOT NULL
	,name_normed  varchar2(400)
		GENERATED ALWAYS AS ( replace ( initCap( translate( name_display, '_-', '  ' ) ) , ' ', '' ) )
	,gpx_data CLOB 
	,sdo_geo SDO_GEOMETRY 
	,date_started DATE 
    ,ins_user VARCHAR2(30 CHAR)
    ,ins_date DATE DEFAULT SYSDATE NOT NULL 
	,ts_converted_to_sdo DATE 
	,remarks  varchar2(1000 char)
)
;
alter table alph_tracks add crypto_hash_typ1 raw ( 100 )
;
alter table alph_tracks add constraint alph_track_gpx_uk1 unique( crypto_hash_typ1 )
;