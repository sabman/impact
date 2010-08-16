#!/usr/bin/env ruby

require "rubygems"
require "daemons"
require "FileUtils"
# check if the file is there
if File.exists?('./lib/websocket.rb')
  File.open('/tmp/riat_websocket_root_dir.txt', 'w+') {|f| f.write("#{FileUtils.pwd}") }
  Daemons.run('./lib/websocket.rb')
else
  raise "File not found: './lib/websocket.rb'"
end