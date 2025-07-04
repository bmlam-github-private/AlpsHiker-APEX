CREATE OR REPLACE FUNCTION extract_gpx_element 
  ( pi_clob         IN CLOB 
   )
RETURN CLOB 
/* We only need the inner element <gpx>. 
   If the element has attributes, in particular xmlns, we want to junk them
*/
AS 
  c_start_pattern CONSTANT VARCHAR2(10) := '<gpx';
  c_start_pattern_no_attr CONSTANT VARCHAR2(10) := c_start_pattern||'>';
  c_end_pattern CONSTANT VARCHAR2(10)   := '</gpx>';
  l_start_pos    PLS_INTEGER;
  l_end_pos      PLS_INTEGER;
  l_total_length       PLS_INTEGER;
  l_offset       PLS_INTEGER := 0;
  l_chunk_size CONSTANT PLS_INTEGER := 32767;
  l_piece          VARCHAR2(32767);
  l_result_pass_1      CLOB;
  l_result_pass_2      CLOB;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Input CLOB length: ' || DBMS_LOB.GETLENGTH(pi_clob));
  -- Find start position of c_start_pattern
  l_start_pos := DBMS_LOB.INSTR(pi_clob, c_start_pattern, 1);

  IF l_start_pos = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'start pattern '||c_start_pattern||' not found');
  END IF;
  dbms_output.put_line( 'Ln'||$$plsql_line||' l_start_pos:'|| l_start_pos);

  -- Find end position of c_end_pattern
  l_end_pos := DBMS_LOB.INSTR(pi_clob, c_end_pattern, l_start_pos);

  IF l_end_pos = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'End pattern '||c_end_pattern||' not found');
  END IF;

  -- Add length of c_end_pattern to include it in output
  l_total_length := l_end_pos - l_start_pos + LENGTH(c_end_pattern);

  -- Create a temporary LOB for output
  DBMS_LOB.CREATETEMPORARY(l_result_pass_1, TRUE);

  -- Loop and read in chunks
  WHILE l_offset < l_total_length LOOP
    l_piece := DBMS_LOB.SUBSTR(pi_clob, l_chunk_size, l_start_pos + l_offset);
    DBMS_LOB.APPEND(l_result_pass_1, l_piece);
    l_offset := l_offset + l_chunk_size;
  END LOOP;

  -- Optionally: print or return
  DBMS_OUTPUT.PUT_LINE('Pass 1 Extracted CLOB length: ' || DBMS_LOB.GETLENGTH(l_result_pass_1));
  -- DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(l_result_pass_1, 1000, 1)); -- Preview first 1000 chars
  --
  -- IN Pass 2 remove the attributes of gpx element
  IF dbms_lob.instr( l_result_pass_1, c_start_pattern_no_attr) = 1 
  THEN 
    RETURN l_result_pass_1; -- ok, no need to worry about attributes 
  ELSE 
    DBMS_LOB.CREATETEMPORARY(l_result_pass_2, TRUE);
    -- let simply replace the starting part with c_start_pattern_no_attr , but copy 
    -- what ever comes there after, meaning what comes after the greater sign 
    dbms_lob.append( l_result_pass_2, c_start_pattern_no_attr ); 
    --
    l_offset := 0;
    l_start_pos := dbms_lob.instr( l_result_pass_1, '>') + 1; 
    dbms_output.put_line( 'Ln'||$$plsql_line||' l_start_pos:'|| l_start_pos);
    l_end_pos := DBMS_LOB.INSTR(l_result_pass_1, c_end_pattern, l_start_pos);
    dbms_output.put_line( 'Ln'||$$plsql_line||' l_end_pos:'|| l_end_pos);
    -- Loop and read in chunks
    WHILE l_offset < l_total_length LOOP
      l_piece := DBMS_LOB.SUBSTR(l_result_pass_1, l_chunk_size, l_start_pos + l_offset);
      DBMS_LOB.APPEND(l_result_pass_2, l_piece);
      l_offset := l_offset + l_chunk_size;
    END LOOP;
    --
    RETURN l_result_pass_2;
  END IF; 
END;
/