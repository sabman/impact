#!/usr/bin/env ruby

require "rubygems"
require "daemons"
# check if the file is there
if File.exists?('./lib/websocket.rb')
  Daemons.run('./lib/websocket.rb')
else
  raise "File not found: './lib/websocket.rb'"
end