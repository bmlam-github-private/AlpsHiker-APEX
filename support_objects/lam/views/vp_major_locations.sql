CREATE OR REPLACE VIEW vp_alph_major_locations AS 
SELECT 
	 id 
	,name_display 
	,name_normed 
	,altitude           
	,longitude         
	,latitude         
	,REMARKS
FROM alph_major_locations
/





CREATE OR REPLACE TRIGGER trg_vp_alph_major_locations
INSTEAD OF 
INSERT  OR UPDATE OR DELETE 
ON vp_alph_major_locations
DECLARE 
	c_nl 	CONSTANT VARCHAR2( 2 ) := chr(10);
	v_phon_values		VARCHAR2( 100 CHAR );
	v_similar		BOOLEAN;
	-- 
	FUNCTION sounds_similar
	( pi_new_text VARCHAR2 
	 ,pi_old_text VARCHAR2 
	 ,po_results  OUT	VARCHAR2 
	) RETURN BOOLEAN 
	AS
		v_new	VARCHAR2( 100 CHAR );
		v_old	VARCHAR2( 100 CHAR );
	BEGIN 
		v_new := soundex( pi_new_text ) ; 
		v_old := soundex( pi_old_text ) ;
		po_results := v_old||':'||v_new;
		-- 
		RETURN v_old = v_new;
	END sounds_similar;
BEGIN
	CASE 
	WHEN INSERTING THEN 
		INSERT INTO alph_major_locations 
		( latitude,      longitude,      name_display,      altitude ,      remarks 
		) VALUES (
		  :new.latitude, :new.longitude, :new.name_display, :new.altitude , :new.remarks 
		);
	WHEN UPDATING  THEN 
		v_similar := sounds_similar ( :old.name_display, :new.name_display, po_results => v_phon_values );
		IF NOT v_similar THEN
			RAISE_APPLICATION_ERROR( -20001, 'The new name is not similar to the old name (' 
				|| v_phon_values 
				|| '). Maybe try to clone/delete the row?');
		END IF;
		-- 
		UPDATE alph_major_locations 
		SET latitude = :new.latitude
			, longitude = :new.longitude
			, remarks = :new.remarks
			, name_display = :new.name_display
			, altitude = :new.altitude
		WHERE id = :new.id
		;
	WHEN DELETING THEN 
		DELETE  alph_major_locations 
		WHERE id = :old.id
		;
	END CASE;
EXCEPTION
    WHEN OTHERS THEN
        pck_std_log.error( a_comp=> $$PLSQL_UNIT, a_subcomp=> 'Ln'||$$plsql_line
            , a_err_code=> sqlcode
	, a_text=> 
		' new.id:'||:new.id
		||' old.id:'||:old.id
		||' sqlerrm:'|| sqlerrm ||c_nl||dbms_utility.format_call_stack );
        RAISE;
END;
/

show errors 

