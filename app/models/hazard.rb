class Hazard 
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
    @@response ||= HTTParty.get("http://www.aifdr.org:8080/geoserver/rest/workspaces/hazard/coverages.json",
      { :basic_auth => {:username => "admin", :password => "geoserver"}})
    @@response
  end
  
end

# == Schema Information
#
# Table name: hazards
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  service_url :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#


# @@geoserver_url = YAML.load_file("#{Rails.root}/config/geoserver.yml")["host"]
# @@aifdr_geoserver_url =  "http://www.aifdr.org:8080/geoserver"
# @@aifdr_rest_url      = "http://www.aifdr.org:8080/geoserver/rest/workspaces/hazard"
# @@gs_username         = YAML.load_file("#{Rails.root}/config/geoserver.yml")["production"]["username"]
# @@gs_password         = YAML.load_file("#{Rails.root}/config/geoserver.yml")["production"]["password"]
