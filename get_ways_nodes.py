#! /usr/bin/python3 
"""
It is probably not a good idea to dump the overpass query result into text file and parse its content. Reason: in the text file, the nodes occur before the ways so we would have to write code to figure out which nodes belong to which way.
Better to use overpy to loop thru each way requesting the nodes. 

In addition we likely need a method to compute the positioning sequence of each way by looking into the end nodes so that we could concatinate a single line, for our purpose of showing a railway route from city A to B.
"""

import overpy
import sys
import json
from dbx import _dbx , _errorExit

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

def query_ways ( query ):
	# Initialize the Overpy API
	api = overpy.Overpass()

	# Execute the query
	result = api.query(query)
	if len( result.ways ) == 0:
		_errorExit( "No ways found in query result")
	_dbx( "relations: %d" % len( result.relations) )
	_dbx( "ways: %d" % len( result.ways) )
	_dbx( "first level nodes: %d" % len( result.nodes) )
	#
	return result 

def extract_ways_meta( ways ):
	for way in ways:
		name = way.tags.get( "name" )
		info = f"{way.id}"
		if name != None: 
			info += f" {name}"
		_dbx( info )

# Main script logic
if __name__ == "__main__":
	# Ensure the file path is provided as a command-line argument
	if len(sys.argv) != 2:
		_dbx("Usage: python script.py <file_path>")
		sys.exit(1)  # Exit with an error code if no file path is provided

	# Get the file path from the first command-line argument
	file_path = sys.argv[1]

	# Call the function to read the file and get the lines
	try:
		query = extract_query( file_path )
		# Print the result
		_dbx( query )
		result = query_ways( query )
		extract_ways_meta( result.ways)
	except FileNotFoundError:
		print(f"Error: The file '{file_path}' was not found.")
	except Exception as e:
		print(f"An error occurred: {e}")

