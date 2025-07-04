#! /usr/bin/python3 

# this code by ChatGpt works instantly!
# in the output time value, there is no trailing letter Z, whereas EasyTrails export has the trailing letter.
# but does not seem to matter. But for imported track to be searchable in EasyTrails, it took a few minutes"

import gpxpy
import gpxpy.gpx
from datetime import datetime, timedelta
from geopy.distance import geodesic

# Load GPX file
with open('/Users/bmlam/Downloads/bergfextour_helm-und-sillianer-hutte.gpx', 'r') as f:
    gpx = gpxpy.parse(f)

# Start time
start_time = datetime(datetime.now().year, 1, 1, 0, 0, 0)
current_time = start_time

# Walking speed in m/s
speed_m_per_s = 2000 / 3600  # 2 km/h

for track in gpx.tracks:
    for segment in track.segments:
        previous_point = None
        for point in segment.points:
            if previous_point:
                dist = geodesic(
                    (previous_point.latitude, previous_point.longitude),
                    (point.latitude, point.longitude)
                ).meters
                delta_time = timedelta(seconds=dist / speed_m_per_s)
                current_time += delta_time
            point.time = current_time
            previous_point = point

# Write modified GPX
with open('output.gpx', 'w') as f:
    f.write(gpx.to_xml())
