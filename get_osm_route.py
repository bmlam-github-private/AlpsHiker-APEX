#!/usr/bin/python3 
""" ultimately this script should be abloe to accept an OSM relation id or tags which uniquely specify a relation of ways and nodes
    and by way of resolving ways to nodes on the fly, if needed, create a GEOSON content that allows us to display the nodes in 
    an Oracle APEX map region. The APEX app is just a user of the JSON content, not part of this program.

    As build blocks, we shall have methods which:
    * counts the child ways and child nodes of a relation from an existing JSON content as provided from OSM, in the structure of Turbo Overpass 
    * outputs the tags of the relation in the Overpass JSON content 
    * resolves peer ways to nodes (we may even resolve the nodes even if the relation may content nodes). We explicitly want to input a list 
      of ways instead of single way to improve performance
    * generates a dummy GEOJSON text for lines 
    * fetch JSON data based on an Overpass query and stores the result to a file .. sounds simple, but the APIs tend to return the result as internal tree.
    * formats the JSON data which has no newlines in a brain-friendly way. Actually the result from Overpass is alreay is a JSON object, when we print it, 
      the whole thing is dumped as a single line. But json.dumps() has an optional parameter indent which will give us a nice representation (though no 
      fancy config capabilities). to traverse the json object, we can do it directly without going thru str representation!


    Further features:
    * a keyed list of Overpass query templates will be defined
"""

overpass_queries = {}

def set_overpass_queries():
    global overpass_queries
    overpass_queries[ "berlin_cat_2_stations"] =  """
        area["name"="Berlin"]; 
        node["railway"="station"] ["railway:station_category" = "2"](area);  """

def parse_args():
    import argparse
    parser = argparse.ArgumentParser(description="Sample script with flags and values")

    # Value arguments
    parser.add_argument('--input', '-i', type=str, help='Input file path', required=True)
    parser.add_argument('--output', '-o', type=str, help='Output file path', required=False)

    # Flag arguments (store_true makes them act like switches)
    parser.add_argument('--verbose', '-v', action='store_true', help='Enable verbose mode')
    parser.add_argument('--debug', action='store_true', help='Enable debug mode')

    args = parser.parse_args()
    return args 

def main_using_args():
    prog_args = parse_args()
    # Example usage
    if prog_args.verbose:
        print("Verbose mode is on")

    if prog_args.debug:
        print("Debug mode is on")

    print(f"Input file: {prog_args.input}")
    if prog_args.output:
        print(f"Output file: {prog_args.output}")
    else:
        print("No output file specified")

def count_members_in_relation_json():
    import json
    from collections import defaultdict

    # Sample JSON data (as Python dictionary)
    data = {
        "type": "relation",
        "id": 13059450,
        "members": [
            { "type": "node", "ref": 1654971118, "role": "stop" },
            { "type": "way", "ref": 39974222, "role": "platform" },
            { "type": "node", "ref": 1452724488, "role": "stop" },
            { "type": "relation", "ref": 3218069, "role": "platform" },
            { "type": "node", "ref": 2578181091, "role": "stop" },
            { "type": "relation", "ref": 3376139, "role": "platform" },
            { "type": "node", "ref": 934850237, "role": "stop" },
            { "type": "way", "ref": 80138795, "role": "platform" },
            { "type": "node", "ref": 938106502, "role": "stop" },
            { "type": "way", "ref": 49516467, "role": "platform" },
            { "type": "node", "ref": 1451124565, "role": "stop" },
            { "type": "way", "ref": 901360842, "role": "platform" },
            { "type": "node", "ref": 248804218, "role": "stop" },
            { "type": "node", "ref": 935572603, "role": "stop" },
            { "type": "relation", "ref": 4624917, "role": "platform" },
            { "type": "node", "ref": 1303589589, "role": "stop" },
            { "type": "relation", "ref": 15039284, "role": "platform" },
            { "type": "node", "ref": 1882504763, "role": "stop" }
        ]
    }

    # Count by (type, role)
    counter = defaultdict(int)

    for member in data["members"]:
        key = (member["type"], member["role"])
        counter[key] += 1

    # Print result
    for (typ, role), count in sorted(counter.items()):
        print(f"{typ:8} {role:10}: {count}")

def demo_query_and_dump_json_via_url():
    """ 
        this method just dumps an empty "elements" attribute !
    """
    import requests

    # Your Overpass query (example: all railway stations in Berlin)
    overpass_query = """
    [out:json][timeout:25];
    area["name"="Berlin"];
    node["railway"="station"] ["railway:station_category" = "2"](area);
    """

    # Overpass API endpoint (you can also try other public endpoints)
    url = "https://overpass-api.de/api/interpreter"

    # Send the query
    response = requests.post(url, data={'data': overpass_query})

    # Check and print the raw JSON response as text
    if response.status_code == 200:
        result_text = response.text
        # print(result_text)  # Or use: json_data = response.json()
        print( response.json )  
    else:
        print(f"Error: {response.status_code}")

def get_query_result ( query ):
    import overpass 
    api = overpass.API()
    result = api.Get(query)
    return result 

def demo_query_and_dump_json_via_api(  ):
    # Initialize the Overpy API

    # NOTA BENE : specifying the command timeout, out:json, out spells TROUBLE because the api module seems to insert the 2 commands automatically! 

    query =  """    area["name"="Berlin"]; 
                    node["railway"="station"] ["railway:station_category" = "2"](area); 
            """
    # Print the result
    print( "***********++++*** query *****************")
    print( query )
    print( "***********++++*** END of query *****************")
    json_text = qet_query_result ( query )
    print( "***********++++*** Result *****************")
    print( json_text )



if __name__ == '__main__':
    import json 
    #main_using_args()
    #count_members_in_relation_json_via_url() 
    #demo_query_and_dump_json_via_api()
    set_overpass_queries();     
    query = overpass_queries[ "berlin_cat_2_stations" ]

    q_res = get_query_result( query )
    print( json.dumps( q_res, indent= 2 ) )


    #friendly_res = make_json_list_eye_friendly( q_res )
    #print ( friendly_res )
