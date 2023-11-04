create or replace function gracious_to_number( p_value VARCHAR2 ) 
RETURN NUMBER
AS
    l_value varchar(100) := substr( trim( p_value ), 1, 100 );
    l_decimal_char char(1);
    lc_comma CONSTANT char(1) := ',';
BEGIN
    --dbms_output.put_line( 'line '||$$plsql_line );

    select substr( value, 1, 1)
    into l_decimal_char
    from nls_session_parameters
    where parameter = 'NLS_NUMERIC_CHARACTERS';

    if l_decimal_char = lc_comma and instr( l_value , '.' ) > 0 then
       l_value := replace ( l_value, '.', lc_comma );
    end if;
    --dbms_output.put_line( 'l_value: '||l_value||' dec: '||l_decimal_char );
	return to_number( l_value );
EXCEPTION
	WHEN OTHERS THEN
        dbms_output.put_line( 'line '||$$plsql_line );

    RETURN null;
end;
/

show errors
