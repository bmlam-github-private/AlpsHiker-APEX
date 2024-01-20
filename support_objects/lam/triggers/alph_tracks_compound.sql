CREATE OR REPLACE TRIGGER alph_tracks_compound 
FOR INSERT OR UPDATE OR DELETE ON alph_tracks 
COMPOUND TRIGGER
    -- BEFORE STATEMENT section
    BEFORE STATEMENT IS
    BEGIN
        NULL; -- Placeholder for actions before the statement execution
    END BEFORE STATEMENT;

    -- BEFORE EACH ROW section for INSERT or UPDATE
    BEFORE EACH ROW IS
        --v_hash RAW (32767);
    BEGIN
        loginfo( null, ' len of gpx: '|| dbms_lob.getlength( :new.gpx_data ) );
        IF :new.gpx_data IS NOT NULL 
            AND :new.gpx_data <> empty_clob() -- not sure if this is correct way to do 
            AND :new.crypto_hash_typ1 IS NULL 
        THEN  
            :new.crypto_hash_typ1 :=  DBMS_CRYPTO.HASH(:new.gpx_data, 1) ;
        END IF;
    END BEFORE EACH ROW;

    -- AFTER EACH ROW section for INSERT or UPDATE
    AFTER EACH ROW IS
    BEGIN
        NULL;
    END AFTER EACH ROW;

    -- AFTER STATEMENT section
    AFTER STATEMENT IS
    BEGIN
        NULL; -- Placeholder for actions after the statement execution
    END AFTER STATEMENT;

END;
/
