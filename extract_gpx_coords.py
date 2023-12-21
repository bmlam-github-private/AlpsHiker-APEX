#! /usr/bin/python3 

import gpxpy

def extract_coordinates(file_path):
    # Parse the GPX file
    with open(file_path, 'r') as gpx_file:
        gpx = gpxpy.parse(gpx_file)

        # Initialize a list to store coordinates
        coordinates = []

        # Iterate through GPX track segments, points, and extract coordinates
        for track in gpx.tracks:
            for segment in track.segments:
                for point in segment.points:
                    coordinates.append((point.latitude, point.longitude))

    return coordinates

# Replace 'your_file.gpx' with the path to your GPX file
gpx_file_path = '/Users/bmlam/Downloads/Bodenschneid-von-Tegernsee.gpx'

# Extract coordinates
extracted_coordinates = extract_coordinates(gpx_file_path)

# Print the extracted coordinates
for coordinate in extracted_coordinates:
    print(f"Latitude: {coordinate[0]}, Longitude: {coordinate[1]}")
