#! /usr/bin/python3 
"""
It is probably not a good idea to dump the overpass query result into text file and parse its content. Reason: in the text file, the nodes occur before the ways so we would have to write code to figure out which nodes belong to which way.
Better to use overpy to loop thru each way requesting the nodes. 

In addition we likely need a method to compute the positioning sequence of each way by looking into the end nodes so that we could concatinate a single line, for our purpose of showing a railway route from city A to B.
"""

import overpy
import sys
import json
import time 

from dbx import _dbx , _errorExit

overpass_conx = None 

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
	global overpass_conx 

	# Execute the query
	result = overpass_conx.query(query)
	if len( result.ways ) == 0:
		_errorExit( "No ways found in query result")
	_dbx( "relations: %d" % len( result.relations) )
	_dbx( "ways: %d" % len( result.ways) )
	_dbx( "first level nodes: %d" % len( result.nodes) )
	#
	return result 

def get_way_nodes_coordinates( way ):
	_dbx( f" {time.strftime('%X')}: getting nodes for id {way.id}")
	nodes = way.get_nodes( resolve_missing= True )
	str_list = []
	for node in nodes: 
		str_list.append( f"[{node.lon}, {node.lat}]")
	return "[" + ",".join( str_list ) + "]"

def extract_ways_meta( ways ):
	ret_val = ""
	for way in ways:
		name = way.tags.get( "name" )
		info = f"{way.id}"
		if name != None: 
			info += f" {name}"
		#_dbx( info )
		ret_val += "\n" + info 
	return ret_val 

# Main script logic
if __name__ == "__main__":
	# Initialize the Overpy overpass_conx
	overpass_conx = overpy.Overpass()

	# Ensure the file path is provided as a command-line argument
	if len(sys.argv) != 2:
		_dbx("Usage: python script.py <file_path>")
		sys.exit(1)  # Exit with an error code if no file path is provided

	# Get the file path from the first command-line argument
	file_path = sys.argv[1]

	# Call the function to read the file and get the lines
	try:
		query = extract_query( file_path )
	except FileNotFoundError:
		_errorExit(f"Error: The file '{file_path}' was not found.")
	except Exception as e:
	#
		_errorExit(f"An error occurred: {e}")
	_dbx( query )

	result = query_ways( query )
	way_infos = extract_ways_meta( result.ways)
	# print( way_infos )
	line_str_list = []
	for way in result.ways [ 0: 3 ]:
		coord_str= get_way_nodes_coordinates( way )
		_dbx( coord_str )
		line_str_list.append( coord_str )
	multi_line_str = '[' + "\n ,".join ( line_str_list ) + ']'
	geojson_data = '{"type": "MultiLineString" \n , "coordinates": \n' + multi_line_str + ' }'
	print( geojson_data )
