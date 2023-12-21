SET SERVEROUTPUT ON 
--var l_json CLOB

-- create table temp_clob ( tstamp timestamp default systimestamp, remarks varchar2(200 char), content clob );
DECLARE
    bv_json clob;
BEGIN
    bv_json := '{';
    FOR rec IN ( 
    SELECT json_object
        ( 'id'  is id
        , 'name_display' is name_display
        , 'name_normed'  is name_normed
        , 'longitude'    is longitude 
        , 'latitude'     is latitude 
        , 'altitude'     is altitude 
        ) as data 
        FROM alph_mountain
        ORDER BY name_normed
    ) LOOP 
        bv_json := 
            bv_json||chr(10) || ' '
            ||rec.data;
    END LOOP;
        bv_json := 
            bv_json||chr(10) || '}'
            ;
--    :l_json := bv_json;
    insert into temp_clob ( remarks, content ) values ( 'export from alph_mountain', bv_json );
    DBMS_OUTPUT.put_line( 'inserted rows '||sql%rowcount );
END;
/


--def spool_file=/Users/bmlam/xxx.json 
--prompt spooling to &spool_file
--set linesize 500 pages 0 heading off feedback off 
--set termout off trimspool on longchunksize 1000000000 long 1000000000
--SPOOL &spool_file
--PRINT :l_json
--SPOOL OFF 
--
--set linesize 100 pagesize 50 heading on feedback on 

select *
from temp_clob
order by tstamp desc fetch first 3 rows only
;