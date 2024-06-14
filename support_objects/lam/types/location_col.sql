CREATE OR REPLACE TYPE location_type FORCE AS OBJECT 
( longitude NUMBER(10,7)
 ,latitude  NUMBER(10,7)
 ,tool_tip  VARCHAR2( 100 CHAR)
)
/
SHOW ERRORS 

CREATE OR REPLACE TYPE location_col FORCE AS TABLE OF location_type
/
SHOW ERRORS 

