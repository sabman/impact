#!/usr/bin/env ruby

require "rubygems"
require "em-websocket"

# usage = "websocket.rb [start | stop | restart]"

EventMachine.run {
  # EventMachine::WebSocket.stop if ARGV[0] == "stop"

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 5000) do |ws|
      ws.onopen {
        puts "WebSocket connection open"

        # publish message to the client
        ws.send "Hello Client"
      }

      ws.onclose { puts "Connection closed" }
      ws.onmessage { |msg|
        puts "Recieved message: #{msg}"
        ws.send "Pong: #{msg}"
      }
  end
}
