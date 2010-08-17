class Exposure
  @@response = nil
  def self.layers
    @@response ||= self.get_response
    @@response.parsed_response["coverages"]["coverage"]
  end  
  
  def self.layernames
    @@response ||= self.get_response
    layernames = @@response.parsed_response["coverages"]["coverage"].collect{ |h| h["name"]  }
    layernames
  end
  
  private
  
  def self.get_response
    @@response ||= HTTParty.get("http://www.aifdr.org:8080/geoserver/rest/workspaces/exposure/coverages.json",
      { :basic_auth => {:username => "admin", :password => "geoserver"}})
    @@response
  end
end
