CREATE OR REPLACE VIEW major_locations
AS
SELECT 'xx' name, 0.0 longi, 0.0 lati, '???' description FROM dual WHERE 1=0
UNION ALL SELECT 'Nice' , 7.2525 , 43.07, '???'  FROM dual 
UNION ALL SELECT 'xx' , 12 , 34, '???'  FROM dual 
/

COMMENT ON TABLE major_locations IS 'to serve as center of locations. Will be converted to a table'
/