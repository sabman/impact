import sys

f = open('/tmp/riat_websocket_root_dir.txt', 'r')
riat_websocket_root_dir = f.read()
print riat_websocket_root_dir
source_path=riat_websocket_root_dir+"/"+"vendor/geoserver_api"
sys.path.append(source_path)
sys.path.append(riat_websocket_root_dir+"/"+"lib/riat_python_api")

from api import coverage

wcs_url, layername = sys.argv[1], sys.argv[2]
c  = coverage.Coverage(wcs_url, layername)
print c.get_url()

    