#! /usr/bin/python3 
"""
Suppose we have two areas may touch or overlap partially. We want to query the railroad ways within the two areas, figure out if the same way id are in both areas and for each way, merge respectively concatinate the nodes. 
The output should contain all tags of each ways and relevant tags of the nodes in json (not geojson) 
The bounding box of the 2 areas shall be read as command line arguments 
"""

import overpy
import sys, tempfile 
import json
import time 

from dbx import setDebug, _dbx , _errorExit, _infoTs
from merged_object_classes import MergedWay

overpass_conx = None 


def query_ways ( query ):
	global overpass_conx 

	# Execute the query
	result = overpass_conx.query(query )
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
	"""
		to clarify: which tags are relevant? 
		can we simply dump the object and see what is inside? 
	"""
	ret_val = ""
	for way in ways:
		name = way.tags.get( "name" )
		info = f"{way.id}"
		if name != None: 
			info += f" {name}"
		#_dbx( info )
		ret_val += "\n" + info 
	return ret_val 

# Convert the result object to JSON
def result_to_json(result):
	WANT_NODES=False  
	if WANT_NODES:
	    data = {
	        "nodes": [
	            {
	                "id": node.id,
	                "lat": float( node.lat ),
	                "lon": float( node.lon ),
	                "tags": node.tags
	            }
	            for node in result.nodes
	        ],
	        "ways": [
	            {
	                "id": way.id,
	                "nodes": [node.id for node in way.nodes],
	                "tags": way.tags
	            }
	            for way in result.ways
	        ],
	        "relations": [
	            {
	                "id": rel.id,
	                "members": [
	                    {"type": member._type, "ref": member.ref, "role": member.role}
	                    for member in rel.members
	                ],
	                "tags": rel.tags
	            }
	            for rel in result.relations
	        ]
	    }
	else:
	    data = {
	        "ways": [
	            {
	                "id": way.id,
	                "tags": way.tags
	            }
	            for way in result.ways
	        ],
	        "relations": [
	            {
	                "id": rel.id,
	                "members": [
	                    {"type": member._type, "ref": member.ref, "role": member.role}
	                    for member in rel.members
	                ],
	                "tags": rel.tags
	            }
	            for rel in result.relations
	        ]
	    }
	return json.dumps(data, indent=4)

def enrich_ways_with_nodes ( in_ways ):
	""" if in_ways was gotten without nodes due to performance reason. 
		we want to get the nodes on the fly but only one time per way! 
		may be we can mutate the ways directly ? 
	"""
	out_ways= []
	for in_w in in_ways:
		out_w = in_w 
		if len( in_w.nodes ):
			_infoTs( f"way: {out_w.id}")
			out_w.nodes = in_w.get_nodes (resolve_missing = True ) 
		out_ways.append( out_w )
	return out_ways 


def merge_ways ( ways ):
	way_ids = []
	way_codes = []
	for i, i_w in enumerate(ways):
		first_nid = i_w.nodes[0].id
		last_nid = i_w.nodes[len( i_w.nodes ) - 1].id 
		for j, j_w in enumerate ( ways):
			if i != j : # not the sane way 
				if first_nid ==j_w.nodes[ len( j_w.nodes ) - 1].id  or last_nid == j_w.nodes[0].id :
					print( f"way {i_w.id} CONNECTS with way {j_w.id}")

def display_ways ( ways ):
	for way in ways:
		text = f"id: {way.id} "
		if "name" in way.tags:			text += f"name: {way.tags['name']}"
		print( text )

# Main script logic
if __name__ == "__main__":
	setDebug( True )
	# Initialize the Overpy overpass_conx
	overpass_conx = overpy.Overpass()

	# Call the function to read the file and get the lines
	try:
		query = """[out:json] [bbox:47.9500,11.5000,48.2000,11.7500];
			way["railway"="rail"];
			(._;>;);
			out body;
		"""
	except FileNotFoundError:
		_errorExit(f"Error: The file '{file_path}' was not found.")
	except Exception as e:
	#
		_errorExit(f"An error occurred: {e}")
	_dbx( query )
	_infoTs( "Submitting query...")
	result = query_ways( query )
	# print(  result_to_json( result ) )
	#display_ways( result.ways )
	merge_ways( result.ways )
	# useless? enrich_ways_with_nodes( result.ways )
