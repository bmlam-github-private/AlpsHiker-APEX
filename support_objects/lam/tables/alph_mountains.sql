
create table alph_mountain (
	 id number(10)                GENERATED ALWAYS AS IDENTITY PRIMARY KEY 
	,name_display varchar2(100)            NOT NULL
	,name_normed  varchar2(400)           
		GENERATED ALWAYS AS ( replace ( initCap( translate( name_display, '_-', '  ' ) ) , ' ', '' ) )
	,altitude           number(5)
	,longitude          number(13, 10)
	,latitude           number(13, 10)
	,mountain_group_id  number(5) 
	,remarks  varchar2(1000)
)
;
alter table alph_mountain add unique ( name_normed )
;
alter table alph_mountain add unique ( name_display, mountain_group_id)
;
alter table alph_mountain add check ( trim(name_display) = name_display )
;
alter table alph_mountain add check ( latitude between 35 and 50 )
;
alter table alph_mountain add check ( longitude between 2 and 18 )
;

