CREATE OR REPLACE VIEW v_alph_tracks
AS 
Select  
ID,NAME_DISPLAY,NAME_NORMED,GPX_DATA
,SDO_GEO,DATE_STARTED,INS_USER,INS_DATE
,TS_CONVERTED_TO_SDO,REMARKS,CRYPTO_HASH_TYP1 
from alph_tracks 
where 1=1 
;