CREATE OR REPLACE TYPE landmark_type FORCE AS OBJECT 
( unik_key		VARCHAR2(20 CHAR)
 ,place_name	VARCHAR2(100 CHAR)
 ,tool_tip		VARCHAR2(100 CHAR)
 ,longitude NUMBER(10,7)
 ,latitude  NUMBER(10,7)
 ,altitude  NUMBER(5,1)
)
/
SHOW ERRORS 

CREATE OR REPLACE TYPE landmark_col FORCE AS TABLE OF landmark_type
/
SHOW ERRORS 

