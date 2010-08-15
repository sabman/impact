import sys, os, string
import numpy
import unittest
import pycurl
import StringIO
import json
import helper
import datetime
import yaml

source_path="./vendor/geoserver_api"
sys.path.append(source_path)
sys.path.append("./lib/riat_python_api")

stream = file('./config/geoserver.yml', 'r')
gs_config = yaml.load(stream)

from api import Geoserver, write_coverage_to_ascii
# from config import webhost, datadir

webhost="www.aifdr.org"
# webhost_local = "aifdr.nomad-labs.dyndns.org"
webhost_local = gs_config['host']
datadir="./geodata"
# Output workspace
workspace = 'impact'

for arg in sys.argv[1:]:
    print arg
    named_param = helper.parse_named_param(arg)
    if named_param[0] == "bbox":
        bbox = named_param[1]
    if named_param[0] == "timestamp":
        timestamp = named_param[1]
    if named_param[0] == "coordstr":
        coordstr = named_param[1]
    

print bbox 
print timestamp

# Fatality model parameters (Allen 2010:-)
a = 0.97429
b = 11.037

# Locations

if bbox:
    bounding_box = bbox  # Taken from web application
else:
    bounding_box = [95.06, -10.997, 141.001, 5.911]

geoserver = Geoserver('http://%s:8080/geoserver' % webhost,
                      'admin',
                      'geoserver')        

geoserver_local = Geoserver('http://%s/geoserver' % webhost_local,
                    'admin',
                    'geoserver')    

# Download hazard and exposure data
layername = 'earthquake_intensity_1hz10pc50'
print 'Get hazard level:', layername
hazard_raster = geoserver.get_raster_data(coverage_name=layername,
                                          bounding_box=bounding_box,
                                          workspace='hazard',
                                          verbose=True)            
            
#layername = 'landscan_2008'
layername = 'population_2010'
print 'Get exposure data:', layername            
exposure_raster = geoserver.get_raster_data(coverage_name=layername,
                                            bounding_box=bounding_box,
                                            workspace='exposure',
                                            verbose=True)            
                                                 
# Calculate impact
print 'Calculate impact'            
E = exposure_raster.data
H = hazard_raster.data
F = 10**(a*H-b)*E 
                         

# Store result and upload
layername = 'earthquake_fatalities_1hz10pc50'+ '_' + timestamp

output_file = '%s/%s/%s.asc' % (datadir, workspace, layername)
print 'Store result in:', output_file
write_coverage_to_ascii(F, output_file, 
                        xllcorner = bounding_box[0],
                        yllcorner = bounding_box[1])
                                                
# And upload it

print 'Upload to Geoserver:', layername
geoserver_local.create_workspace(workspace)
geoserver_local.upload_coverage(filename=output_file, 
                          workspace=workspace)