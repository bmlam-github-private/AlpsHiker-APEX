#! /usr/bin/python3 

import overpass 
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

def get_query_result ( api, query ):

	# Execute the query
	result = api.Get(query)
	#
	return result 

# Main script logic
if __name__ == "__main__":
	# Ensure the file path is provided as a command-line argument
	if len(sys.argv) != 2:
		print("Usage: python script.py <file_path>")
		sys.exit(1)  # Exit with an error code if no file path is provided

	# Get the file path from the first command-line argument
	file_path = sys.argv[1]

	# Initialize the Overpy API
	api = overpass.API()

	# Call the function to read the file and get the lines
	try:
		query = extract_query( file_path )
		# Print the result
		print( "***********++++*** query *****************")
		print( query )
		print( "***********++++*** END of query *****************")
		json_text = get_query_result( api, query )
		print( "***********++++*** Result *****************")
		print( json_text )
	except FileNotFoundError:
		print(f"Error: The file '{file_path}' was not found.")
	except Exception as e:
		print(f"An error occurred: {e}")

