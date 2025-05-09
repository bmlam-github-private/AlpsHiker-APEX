#! /usr/bin/python3 

def generate_plsql_collection_from_file(filename, collection_name="json_chunks", max_chunk_size = 32000):
    
    with open(filename, "r", encoding="utf-8") as f:
        content = f.read()

    # Escape single quotes for PL/SQL
    content = content.replace("'", "''")

    # Break into chunks
    chunks = [content[i:i+max_chunk_size] for i in range(0, len(content), max_chunk_size)]

    # Start PL/SQL block
    plsql = []
    plsql.append(f"FUNCTION get_clob RETURN CLOB AS ")
    plsql.append(f"  v_return CLOB ;")
    plsql.append(f"  TYPE varchar_table IS TABLE OF VARCHAR2(32767);")
    plsql.append(f"  {collection_name} varchar_table := varchar_table();")
    plsql.append("BEGIN")

    for idx, chunk in enumerate(chunks, 1):
        plsql.append(f"  {collection_name}.EXTEND;")
        plsql.append(f"  {collection_name}({idx}) := '{chunk}';")

    plsql.append("  -- Now you can use the collection here")
    plsql.append(f"  dbms_lob.createtemporary( v_return, FALSE );")
    plsql.append(f"  FOR i IN 1 .. {collection_name}.count LOOP")
    plsql.append(f"    dbms_lob.append( v_return, {collection_name}(i) );")
    plsql.append(f"  END LOOP;")
    plsql.append("  RETURN v_return;")
    plsql.append("END;")

    return "\n".join(plsql)


# Example usage:
output = generate_plsql_collection_from_file("./osm-query-results/oesterreich_2k_berge.json", max_chunk_size= 2000 )
with open("xxx_output_plsql_script.sql", "w", encoding="utf-8") as f:
    f.write(output)

print("PL/SQL script generated!")
