#! /usr/bin/python3 

import json
import geojson





print("GeoJSON file 'ways.geojson' created successfully.")

def extract_from_argv1():
    # Ensure the file path is provided as a command-line argument
    if len(sys.argv) != 2:
        print("Usage: python script.py <file_path>")
        sys.exit(1)  # Exit with an error code if no file path is provided

    # Get the file path from the first command-line argument
    file_path = sys.argv[1]

    # Load the Overpass query result from the existing JSON file
    with open( file_path, 'r') as f:
        data = json.load(f)
    return data

def convert_to_geojson( data ):
    # Process each way and create GeoJSON features
    for way in data.get('elements', []):
        # Ensure the way has at least one node (this will be a valid LineString)
        if 'nodes' in way:
            coordinates = []
            
            # Step 3.1: Get the coordinates of the way's nodes (replace with actual lat/lon data)
            for node_id in way['nodes']:
                # Here, you would replace this with actual data of the nodes if coordinates are available
                # Example of node coordinates (for demonstration purposes):
                node_coordinates = [10.0, 50.0]  # Replace with actual lat/lon of node from OSM data
                coordinates.append(node_coordinates)

            # Step 3.2: Create a GeoJSON feature for this way (LineString)
            feature = {
                "type": "Feature",
                "geometry": {
                    "type": "LineString",
                    "coordinates": coordinates
                },
                "properties": {
                    "id": way['id'],
                    "tags": way.get('tags', {})
                }
            }

            geojson_data["features"].append(feature)

# Main script logic
if __name__ == "__main__":
    data = extract_from_argv1()
# Step 4: Output the GeoJSON data to a file
    geojson_data = convert_to_geojson( data )
    out_file = 'output.geojson'
    with open(out_file, 'w') as f:
        geojson.dump(geojson_data, f)
    print( f"geojson data writeh to {out_file}")

