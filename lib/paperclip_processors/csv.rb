require 'erb'
module Paperclip
  class Csv < Processor
    def initialize(file, options, attachment)
      super
      @file = file
      @options = options
      @current_format = File.extname(@file.path)
      @basename = File.basename(@file.path, @current_format)
      @extension = "json"
      @attachment = attachment
      Rails.logger.info attachment
    end 
    def make
      path = File.dirname(@file.path)
      @file_path = @file.path
      @basename = File.basename(@file.path, ".csv")
      @layername = File.basename(@attachment.path, ".csv")
      t = 
%q{<OGRVRTDataSource>
    <OGRVRTLayer name="<%= @basename %>">
        <SrcDataSource><%= @file_path %></SrcDataSource>
        <GeometryType>wkbPoint</GeometryType>
        <LayerSRS>WGS84</LayerSRS>
        <GeometryField encoding="PointFromColumns" x="x" y="y"/>
    </OGRVRTLayer>
</OGRVRTDataSource>}

      template = ERB.new(t)
      Rails.logger.info template.result(binding)
      vrt = "/tmp/#{@basename}.vrt"
      File.open(vrt, "w"){ |f| f.write(template.result(binding))}
      outfile = "#{path}/#{@basename}.json"
      args = " -f GeoJSON  #{outfile} #{vrt}"
      binary = "/usr/local/bin/ogr2ogr"
      cmd = binary + args 
      Rails.logger.info cmd
      begin
        system(cmd)
      rescue Exception  => e
        raise PaperclipError, "There was an error converting the csv for #{@basename} to geojson (#{outfile})\n #{e.message}"
      end
      File.open(outfile)
    end    
  end
end
