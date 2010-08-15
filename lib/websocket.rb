#!/usr/bin/env ruby

require "rubygems"
require "em-websocket"

# usage = "websocket.rb [start | stop | restart]"

EventMachine.run {
  # EventMachine::WebSocket.stop if ARGV[0] == "stop"
  puts FileUtils.pwd

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 5000) do |ws|
      ws.onopen {
        puts "WebSocket connection open"
        
        # publish message to the client
        ws.send "Hello Client - Click submit to start the Impact analysis"
      }

      ws.onclose { puts "Connection closed" }
      ws.onmessage { |msg|
        ws.send "Impact analysis started..."
        puts FileUtils.pwd
        # system "python ./lib/riat_python_api/run_impact_model.py bbox=[106,-7.5,109,-5]"
        system("sleep 5")
        ws.send "<a href=\"http://aifdr.nomad-labs.dyndns.org/geoserver/wms/kml?layers=impact:earthquake_fatalities_1hz10pc50&amp;legend=true\">View in Google Earth</a>"
      }
  end
}