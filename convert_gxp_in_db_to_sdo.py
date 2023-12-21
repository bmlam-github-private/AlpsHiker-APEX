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
import os

"""
try something like this (from linked in )

from __future__ import print_function

import cx_Oracle
import sys
import getpass

try:
    cx_Oracle.init_oracle_client(config_dir="/home/opc/wallet")
except Exception as err:
    print(err);
    sys.exit(1);

 
password = getpass.getpass()
connection = cx_Oracle.connect('admin',password,'msatp_low')
 
this still needs instant client: current link for Mac Os x : https://www.oracle.com/database/technologies/instant-client/macos-intel-x86-downloads.html 
"""
# Replace the placeholders with your actual values
wallet_path = '/Users/bmlam/Wallet_bmlamatp2-20230727'
if not os.path.exists( wallet_path ):
    wallet_path = '/Users/bmlam/Wallet_bmlamatp2'

db_user = 'lam'
db_password = os.environ['BLOODY_SECRET']
wallet_secret = os.environ['WALLET_SECRET']
db_service = 'bmlamatp2_medium'
print ("sssh: %s" % db_password)
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
cursor = connection.cursor()
query = 'SELECT sysdate FROM dual'
cursor.execute(query)

# Fetch and print the results
for row in cursor:
    print(row)

# Close the cursor and connection
cursor.close()
connection.close()
