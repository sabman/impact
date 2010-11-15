import sys, os, string
import numpy
import unittest
import pycurl
import StringIO
import json
import helper
import datetime
import yaml

f = open('/tmp/riat_websocket_root_dir.txt', 'r')
riat_websocket_root_dir = f.read()
# print riat_websocket_root_dir
source_path=riat_websocket_root_dir+'/vendor/geoserver_api'
sys.path.append(source_path)
sys.path.append(riat_websocket_root_dir+'/lib/riat_python_api')

stream = file(riat_websocket_root_dir+'/config/geoserver.yml', 'r')
gs_config = yaml.load(stream)

from api import Geoserver, write_coverage_to_ascii
# from config import webhost, datadir

webhost="www.aifdr.org"
webhost_port="8080"

# webhost_local = "aifdr.nomad-labs.dyndns.org"
webhost_local = gs_config['development']['host']
webhost_port = gs_config['development']['port']

datadir=riat_websocket_root_dir+"/"+"geodata"

for arg in sys.argv[1:]:
    print arg
    named_param = helper.parse_named_param(arg)
    if named_param[0] == "bbox":
        bounding_box    = named_param[1]
    if named_param[0] == "timestamp":
        timestamp       = named_param[1]
    if named_param[0] == "hazard_layer":
        hazard_layer    = named_param[1]
    if named_param[0] == "exposure_layer":
        exposure_layer  = named_param[1] 
    if named_param[0] == "impact_layer":
        impact_layer    = named_param[1]    

# FIXME: add validations to check for all needed layers and bbox
# print "Got paramters:"
# print bbox 
# print timestamp
# print hazard_layer
# print exposure_layer
# print impact_layer

# Fatality model parameters (Allen 2010:-)
a = 0.97429
b = 11.037

# Locations
geoserver = Geoserver('http://%s:%s/geoserver' % (webhost webhost_port),
                      'admin',
                      'geoserver')        

geoserver_local = Geoserver('http://%s/geoserver' % webhost_local,
                    'admin',
                    'geoserver')

# Download hazard and exposure data
layername = hazard_layer
print 'Get hazard level:', layername
hazard_raster = geoserver.get_raster_data(coverage_name=layername,
                                          bounding_box=bounding_box,
                                          workspace='hazard',
                                          verbose=True)            

#layername = 'landscan_2008'
layername = exposure_layer
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
layername = impact_layer
# Output workspace
workspace = 'impact'

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