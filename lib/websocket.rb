#!/usr/bin/env ruby

require "rubygems"
require "em-websocket"
require "yaml"
require "fileutils"
require 'json'

# usage = "websocket.rb [start | stop | restart]"

File.open('/tmp/riat_websocket_root_dir.txt', 'w+') {|f| f.write("#{FileUtils.pwd}") }
riat_websocket_root_dir = File.open('/tmp/riat_websocket_root_dir.txt' ).read
# riat_websocket_root_dir = FileUtils.pwd

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
          timestamp = Time.now.strftime('%Y%m%d%H%M%S')          
          impact_layername = "#{data["exposure"]}_#{data["hazard"]}_#{timestamp}"

          geoserver_url = YAML.load_file("#{riat_websocket_root_dir}/./config/geoserver.yml")['host']
          cmd = "python #{riat_websocket_root_dir}/./lib/riat_python_api/run_impact_model.py \\
            bbox=[#{data["bounding_box"].join(",")}] \\
            timestamp=#{timestamp} \\
            hazard_layer=#{data["hazard"]} \\
            exposure_layer=#{data["exposure"]} \\
            impact_layer=#{impact_layername}"
          puts "\n\n>>>>> #{cmd}"
          system cmd
          resp = { "impact" => {
                  "timestamp"     => timestamp,
                  "impact_layername" => impact_layername,
                  "bounding_box"  => bbox,
                  "kml"           => "http://#{geoserver_url}/geoserver/wms/kml?layers=#{impact_layername}&legend=true",
                  "wms"           => "http://#{geoserver_url}/geoserver/wms"
                  
                }}
          pp resp
          ws.send resp.to_json
        end
      }
  end
}

# "wms"           => "http://www.aifdr.org:8080/geoserver/wms?service=wms"
# "wcs"           =>  "http://www.aifdr.org:8080/geoserver/wcs?service=wcs&version=1.0.0&bbox=...&coverage=#{impact_layername}&crs=...&resx=...&resy=..."
