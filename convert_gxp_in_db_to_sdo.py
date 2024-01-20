#! /usr/bin/python3 
#--! /usr/local/bin/python3 # on sfw-iMac?
"""
Suppose gpx data are stored in an Oracle ATP database table. There is also a column for SDO_GEOMETRY in the table which 
is the line presentation of the gpx track. 
This program connects to the database, checks which rows in the table has gpx data but no sdo_geometry yet. For these rows
the gpx data will be read, sent to the  program extract_coords.py which will convert the gpx data to the Geojson format, then uses
sdo_util.from_geojson to set/populate the sdo_geometry column. 
"""

DATA_TABLE_NAME="XYZ_TRACKS"
GPX_COLUMN="GPX_DATA"
SDO_COLUMN="SDO_GEO"
TIMESTAMP_COLUMN="TS_CONVERTED_TO_SDO"

import oracledb # cx_Oracle requires instant client which we do not want to bother with!
#import cx_Oracle 
import gpxpy
import os
import tempfile 

def extract_coordinates(file_path):
    # Parse the GPX file
    with open(file_path, 'r') as gpx_file:
        gpx = gpxpy.parse(gpx_file) # gpxpy only has API to deal with a file handle opened for read, no API for parsing a string! 

        # Initialize a list to store coordinates
        coordinates = []

        # Iterate through GPX track segments, points, and extract coordinates
        for track in gpx.tracks:
            for segment in track.segments:
                for point in segment.points:
                    coordinates.append((point.latitude, point.longitude))

    return coordinates

def dump_text_to_temp_file ( text_string ): 
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as temp_file:
        temp_file.write(text_string)
        temp_file_path = temp_file.name  # Get the path of the temporary file

    return temp_file_path

def make_linestring_geojson ( coordinates ):
    """ example 
    {
    "type": "LineString", 
    "coordinates": [
        [30.0, 10.0],
        [10.0, 30.0],
        [40.0, 40.0]
    ]
}
    """
    coordinates_value = "["
    i= 0 
    for coord in coordinates:
        if i > 0:  coordinates_value += "," 
        coordinates_value += "[%f,%f]" % ( coord[1], coord[0] ) # geojson has longitute first, latitude second
        i+= 1 
        if ( i % 10 ) == 9:
            coordinates_value += "\n"
        # during test: if ( i >= 20 ): break 

    coordinates_value += "\n]"

    return '{ "type": "LineString", \n "coordinates": ' +  coordinates_value + '}'

# Replace the placeholders with your actual values
wallet_path = '/Users/bmlam/Wallet_bmlamatp2-20230727'
if not os.path.exists( wallet_path ):
    wallet_path = '/Users/bmlam/Wallet_bmlamatp2'

db_user = 'lam'
db_password = os.environ['BLOODY_SECRET']
wallet_secret = os.environ['WALLET_SECRET']
db_service = 'bmlamatp2_medium'
# print ("sssh: %s" % db_password)
# Set up the connection
#oracledb.init_oracle_client( config_dir = wallet_path )
connection = oracledb.connect(
    user=db_user
    ,password=db_password
    ,config_dir=wallet_path
    ,dsn=db_service
    # mode=cx_Oracle.SYSDBA,  # Use cx_Oracle.SYSDBA if you need SYSDBA privileges
    ,encoding='UTF-8'
    ,nencoding='UTF-8'
    ,wallet_password=wallet_secret
    ,wallet_location=wallet_path
)

# Execute the query
cursor_updatable = connection.cursor()
query = """SELECT id, name_display, gpx_data 
FROM alph_tracks 
WHERE ts_converted_to_sdo IS NULL AND gpx_data IS NOT NULL 
ORDER BY id FETCH FIRST 10 ROWS ONLY
"""
cursor_updatable.execute(query)

# Fetch the rows
rows_updatable = cursor_updatable.fetchall()
cursor_updatable.close()

cursor_do_update = connection.cursor()
update_stmt = """ UPDATE alph_tracks 
    SET sdo_geo = sdo_util.from_geojson( :geojson )
        , ts_converted_to_sdo = sysdate
    WHERE id = :id
"""

try:
    for row in rows_updatable:
        (id, name_display, gpx_data ) = row 
        print(id)
        print(name_display)

        if gpx_data:
            text_string = gpx_data.read()
            # print(text_string)
            gpx_file = dump_text_to_temp_file( text_string )

            coordinates = extract_coordinates( gpx_file )
            #for coordinate in  coordinates[0:3] :            print(f"Latitude: {coordinate[0]}, Longitude: {coordinate[1]\n}")
            geojson = make_linestring_geojson ( coordinates )
            # print( geojson )
            if True:
                bind_values = { 'geojson': geojson, 'id': id }
                cursor_do_update.execute( update_stmt, bind_values )

                connection.commit()
        else:
            print("gpx_data is empty or NULL")
except oracledb.Error as error:
    print("Error occurred:", error)
    connection.rollback()  # Rollback changes in case of an error


# Close the cursor and connection
connection.close()

