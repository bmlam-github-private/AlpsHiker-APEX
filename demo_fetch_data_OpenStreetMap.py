#! /usr/bin/python3 

import overpy
import sys


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
def run_query ( query ):
	# Initialize the Overpy API
	api = overpy.Overpass()

	# Execute the query
	result = api.query(query)
	print( "first level nodes: %d" % len( result.nodes) )
	if len( result.nodes ) > 0:
		print( "Examples:")
		print_nodes( result.nodes, 99 )

	print( "ways: %d" % len( result.ways) )
	if len( result.ways ) > 0:
		print( "nodes of way 0:" )
		way_0 = result.ways[0]
		nodes = way_0.get_nodes( resolve_missing= True)
		print_nodes( nodes )


def print_nodes ( nodes, upperBound = 3):  
	for node in nodes [ 0 : upperBound ]:
	    print(f"Node ID: {node.id}")
	    # attribute name does NOT exist 
	    print( "name: " + node.tags.get("name") )
	    print(f"Latitude: {node.lat}")
	    print(f"Longitude: {node.lon}")
	    print()

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
