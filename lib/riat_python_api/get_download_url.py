import sys, os

f = open('/tmp/riat_websocket_root_dir.txt', 'r')
riat_websocket_root_dir = f.read()
f.close
source_path=riat_websocket_root_dir+"/"+"vendor/geoserver_api"
sys.path.append(source_path)
sys.path.append(riat_websocket_root_dir+"/"+"lib/riat_python_api")
from api import coverage

wcs_url, layername = sys.argv[1], sys.argv[2]
c  = coverage.Coverage(wcs_url, layername)
wcs_url_file =  riat_websocket_root_dir+'/lib/riat_python_api/wcs_url.txt'
os.system("rm "+wcs_url_file)
f = open(wcs_url_file, 'w')
f.write(c.get_url())
f.close