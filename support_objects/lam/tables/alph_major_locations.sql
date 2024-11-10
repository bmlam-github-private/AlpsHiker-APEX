
create table alph_major_locations (
	 id number(10)                GENERATED ALWAYS AS IDENTITY PRIMARY KEY 
	,name_display varchar2(100)            NOT NULL
	,name_normed  varchar2(400)           
		GENERATED ALWAYS AS ( replace ( initCap( translate( name_display, '_-', '  ' ) ) , ' ', '' ) )
	,altitude           number(5)
	,longitude          number(13, 10)
	,latitude           number(13, 10)
	,remarks  varchar2(1000)
)
;
alter table alph_major_locations add unique ( name_normed )
;
alter table alph_major_locations add unique ( name_display )
;
alter table alph_major_locations add check ( trim(name_display) = name_display )
;
alter table alph_major_locations add check ( abs( latitude ) BETWEEN 0 and 90 )
;
alter table alph_major_locations add check ( abs( longitude) BETWEEN 0 and 180 )
;
alter table alph_major_locations add ( country_code VARCHAR2(3 CHAR) )
;

