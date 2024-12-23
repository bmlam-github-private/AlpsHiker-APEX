#! /usr/bin/python3 

import overpy
import sys
import json

def extract_query (file_path):
    # Open the file in read mode
    with open(file_path, 'r') as file:
        # Read all lines and filter out empty lines and lines starting with '#'
        lines = [
            line.strip()  # Remove leading/trailing whitespaces from each line
            for line in file
            if line.strip() and not line.strip().startswith('#')
        ]
    return "\n".join( lines )



# Query to fetch all railway tracks (you can modify the area or filter based on specific criteria)
"""
[out:json];
area[ "name" = "Germany" ]; 
way[railway](area);  // Example for the area indicated
out body;
"""
""" check this site for query tutorial: https://osm-queries.ldodds.com/tutorial/02-node-output.osm.html
"""

def run_query ( query ):
	# Initialize the Overpy API
	api = overpy.Overpass()

	# Execute the query
	result = api.query(query)
	print( "got result so far")
	print_result ( result )
	# 
	if False:
		print( "relations: %d" % len( result.relations) )
		print( "ways: %d" % len( result.ways) )
		print( "first level nodes: %d" % len( result.nodes) )
		if len( result.nodes ) > 0:
			print( "Examples:")
			print_nodes( result.nodes, 99 )

		if len( result.ways ) > 0:
			print_ways( result.ways )
			# 
			print( "nodes of way 0:" )
			way_0 = result.ways[0]
			nodes = way_0.get_nodes( resolve_missing= True)
			print_nodes( nodes )
		if len( result.relations ) > 0:
			print_relations( result.relations )

def print_result ( result ):
	# Use list comprehension to extract relevant data for both nodes and ways
	# Convert the result to JSON

	# unfortunatey, the following line in "ways" caused error due to missing nodes. 
	# "nodes": way.nodes,
	# this is a running-away operation: "nodes": way.get_nodes( resolve_missing= True),

	result_json = {
				"nodes": [
						{
								"id": node.id,
								"lat": node.lat,
								"lon": node.lon,
								"tags": node.tags,
						}
						for node in result.nodes
				],
				"ways": [
						{
								"id": way.id,
								"nodes": way.get_nodes( resolve_missing= True)
						}
						for way in result.ways
				],
				"relations": [
						{
								"id": relation.id,
								"members": [
										{"type": member.role, "ref": member.ref} for member in relation.members
								],
								"tags": relation.tags,
						}
						for relation in result.relations
				]
		}	# Output the result as a JSON string
	print(result_json)

def print_nodes ( nodes, upperBound = 3):  
	for node in nodes [ 0 : upperBound ]:
	    print(f"Node ID: {node.id}")
	    # attribute name does NOT exist 
	    name= node.tags.get("name") 
	    if name: print( "name: " + name )
	    print(f"Latitude: {node.lat}")
	    print(f"Longitude: {node.lon}")
	    print()

def print_ways( ways ):
	for i, way in enumerate( ways ): 
		name = way.tags.get( "name")
		if name: 
			nodes = way.get_nodes( resolve_missing= True)
			node_cnt = len ( nodes )
			print( f"Way {i}: {name} has {node_cnt} nodes" )

def print_relations( relations ):
	for i, relation in enumerate( relations ): 
		name = relation.tags.get( "name")
		if name: 
			print( f"Relation {i}: {name}" )

# Main script logic
if __name__ == "__main__":
    # Ensure the file path is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python script.py <file_path>")
        sys.exit(1)  # Exit with an error code if no file path is provided

    # Get the file path from the first command-line argument
    file_path = sys.argv[1]

    # Call the function to read the file and get the lines
    try:
        query = extract_query( file_path )
        # Print the result
        print( query )
        run_query( query )
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")
