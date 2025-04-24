#! /usr/bin/python3 

def generate_plsql_collection_from_file(filename, collection_name="json_chunks"):
    max_chunk_size = 32000
    with open(filename, "r", encoding="utf-8") as f:
        content = f.read()

    # Escape single quotes for PL/SQL
    content = content.replace("'", "''")

    # Break into chunks
    chunks = [content[i:i+max_chunk_size] for i in range(0, len(content), max_chunk_size)]

    # Start PL/SQL block
    plsql = []
    plsql.append("DECLARE")
    plsql.append(f"  TYPE varchar_table IS TABLE OF VARCHAR2(32767);")
    plsql.append(f"  {collection_name} varchar_table := varchar_table();")
    plsql.append("BEGIN")

    for idx, chunk in enumerate(chunks, 1):
        plsql.append(f"  {collection_name}.EXTEND;")
        plsql.append(f"  {collection_name}({idx}) := '{chunk}';")

    plsql.append("  -- Now you can use the collection here")
    plsql.append("  NULL;")
    plsql.append("END;")
    plsql.append("/")

    return "\n".join(plsql)


# Example usage:
output = generate_plsql_collection_from_file("./osm-query-results/oberbayer_2k_berge.json")
with open("output_plsql_script.sql", "w", encoding="utf-8") as f:
    f.write(output)

print("PL/SQL script generated!")