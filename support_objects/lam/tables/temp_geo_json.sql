CREATE TABLE temp_geo_json 
( sess_id NUMBER
 ,json_text clob 
 );
 alter table temp_geo_json add (layer_id NUMBER )
 ;
 alter table temp_geo_json add (insert_ts timestamp default systimestamp )
 ;
 alter table temp_geo_json add (remarks varchar2(4000 CHAR) )
 ;
alter table temp_geo_json add constraint ensure_json CHECK ( json_text  IS JSON );
