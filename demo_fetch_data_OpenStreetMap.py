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
	print( "relations: %d" % len( result.relations) )
	print( "ways: %d" % len( result.ways) )
	print( "first level nodes: %d" % len( result.nodes) )
	#
	return result 
	# 
	if False:
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

def print_ways_names( ways ):
	occ_cnt = {}
	for way in ways:
		name = way.tags.get( "name")
		if name in occ_cnt:	occ_cnt[ name ] += 1
		else:				occ_cnt[ name ] = 1
	print( "Distinct ways with cnt")
	print( *occ_cnt.items() )

def merge_ways_to_geojson ( ways ):
	text = ""
	seq = 0 
	for way in ways:
		nodes = way.get_nodes( resolve_missing= True)
		for i, node in enumerate( nodes ):
			point_str = '[' + str(node.lon) + ', ' + str(node.lat) +']'
			if seq % 5 == 4:
				text +=  '\n  ' 
			if seq > 0:
				text += ',' 
			text += point_str
			seq += 1 
	text = '{"type": "LineString"\n ,"coordinates": [' + text + ']}'  
	return text 

def nodes_to_geojson ( nodes ):
	text = ""
	seq = 0 
	for i, node in enumerate( nodes ):
		point_str = '[' + str(node.lon) + ', ' + str(node.lat) +']'
		if seq % 5 == 4:
			text +=  '\n  ' 
		if seq > 0:
			text += ',' 
		text += point_str
		seq += 1 
	text = '{"type": "LineString"\n ,"coordinates": [' + text + ']}'  
	return text 


def ways_to_json( ways , upperBound= 10 ):
	""" only for evauating purpose, the output is not targeted for further automated processing
	"""
	ways_output = []
	# print( f"len of ways: {len(ways)}")
	for i, way in enumerate( ways [0 : upperBound] ): 
		#print( f"way id: {way.id}")
		#print( f"tags of ways: {way.tags}")
		name = way.tags.get( "name" )
		if name == None: name = "None"
		nodes = way.get_nodes( resolve_missing= True)
		node_cnt = len ( nodes )
		way_output = {  "way_id": str( way.id),
						"way_name": name , 
						"node_cnt": node_cnt , 
						"nodes": [
							{
									"id": str( node.id),
									"lat": str( node.lat),
									"lon": str( node.lon)
							}
						for node in nodes
						]
			}
		ways_output.append( way_output )
		# 
	return  ways_output

def way_to_geojson ( way ):
	nodes = way.get_nodes( resolve_missing= True)
	""" doing it with list comprehension has the issue that json.dumps failed on decimal type value!
	geojson = { "type" : "LineString"
				, "coordinates": [ [str(node.lon), str(node.lat) ] for node in nodes ]
	}
	return json.dumps( geojson, indent= 1)
	""" 
	text = ""
	for i, node in enumerate( nodes ):
		point_str = '[' + str(node.lon) + ', ' + str(node.lat) +']'
		if i % 5 == 4:
			text +=  '\n  ' 
		if i > 0:
			text += ',' 
		text += point_str
	text = '{"type": "LineString"\n ,"coordinates": [' + text + ']}'  

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
		result = run_query( query )
		#if "want to browso only" == "yes":
		#	ways_json= ways_to_json( result.ways, upperBound= 100 )
		#	print(json.dumps(ways_json, indent=2))
		if "want to print first ways as geojson":
			for i, way in enumerate( result.ways): 
				if i > 3: 
					exit 
				else:
					print( way_to_geojson( way ) ) 
		# print_ways_names( result.ways )
		#json_text = merge_ways_to_geojson ( result.ways )
		json_text = nodes_to_geojson( result.nodes )
		print( json_text )
	except FileNotFoundError:
		print(f"Error: The file '{file_path}' was not found.")
	except Exception as e:
		print(f"An error occurred: {e}")


def print_result ( result ): # just as references 
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
