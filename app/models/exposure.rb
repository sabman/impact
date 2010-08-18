class Exposure  
  def self.layers
    response = HTTParty.get("http://www.aifdr.org:8080/geoserver/rest/workspaces/exposure/coverages.json",
      { :basic_auth => {:username => "admin", :password => "geoserver"}})
    response.parsed_response["coverages"]["coverage"]
  end  
end
