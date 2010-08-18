class Hazard 
  @@geoserver_url = YAML.load_file("#{Rails.root}/config/geoserver.yml")["host"]
  @@aifdr_geoserver_url =  "http://www.aifdr.org:8080/geoserver"
  @@aifdr_rest_url = "http://www.aifdr.org:8080/geoserver/rest/workspaces/hazard"  
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

