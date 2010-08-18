#!/usr/bin/env ruby

require "rubygems"
require "em-websocket"
require "yaml"
require "fileutils"
require 'json'

# usage = "websocket.rb [start | stop | restart]"

# riat_websocket_root_dir = File.open('/tmp/riat_websocket_root_dir.txt' ).read
riat_websocket_root_dir = FileUtils.pwd

EventMachine.run {
  # EventMachine::WebSocket.stop if ARGV[0] == "stop"
  puts riat_websocket_root_dir
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 5000) do |ws|
      ws.onopen {
        puts "WebSocket connection open"

        # publish message to the client
        ws.send({"message" => "Click submit to start the Impact analysis"}.to_json)
      }

      ws.onclose { puts "Connection closed" }
      ws.onmessage { |msg|
        puts msg
        if msg == nil or msg == ''
          ws.send({"message" => "Please provide bounding coordinates e.g: [106,-7.5,110,-3]"}.to_json)
        else
          require "pp"; pp msg
          data = JSON.parse(msg)
          bbox = data["bounding_box"]
          coordstr = bbox.join("_")
          timestamp = Time.now.strftime('%Y%m%d%H%M%S')          
          impact_layername = "impact:fatalities_#{data["hazard"]}_#{timestamp}"
          
          geoserver_url = YAML.load_file("#{riat_websocket_root_dir}/./config/geoserver.yml")['host']
          cmd = "python #{riat_websocket_root_dir}/./lib/riat_python_api/run_impact_model.py \
            bbox=[#{data["bounding_box"].join(",")}]  \
            timestamp=#{timestamp}        \
            hazard=#{data["hazard"]}      \
            exposure=#{data["exposure"]}  \
            impact_layername=#{impact_layername}"
          puts "\n\n>>>>> #{cmd}"
          system cmd
          resp = { "impact" => {
                "timestamp"     => timestamp,
                "impact_layername" => impact_layername,
                "bounding_box"  => bbox,
                "kml"           => "http://#{geoserver_url}/geoserver/wms/kml?layers=#{impact_layername}&legend=true"},
                "wms"           => "http://www.aifdr.org:8080/geoserver/wms?service=wms",
                "wcs"           =>  "http://www.aifdr.org:8080/geoserver/wcs?service=wcs&version=1.0.0&bbox=...&coverage=#{impact_layername}&crs=...&resx=...&resy=..."
                }
          ws.send resp.to_json
          
          # "
          # <br/>
          # <h3>New Impact Results</h3>
          # <p>
          #   <strong>Timestamp:</strong>     #{timestamp}<br/>
          #   <strong>Layer name:</strong>     #{layername}<br/>
          #   <strong>Bounding box::</strong> #{msg}<br/>
          #   
          #   <img border=\"0\" src='/images/Google-Earth-32.png'/>
          #   <a href=\"http://#{geoserver_url}/geoserver/wms/kml?layers=#{layername}&legend=true\">
          #     View impact in Google Earth
          #   </a>            
          # </p>"          
        end
      }
  end
}
