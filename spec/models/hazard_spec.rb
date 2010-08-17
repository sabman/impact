require 'spec_helper'

describe Hazard do
  it "should return all availalbe layers" do
    Hazard.layers.should include({
        "href"=>"http://www.aifdr.org:8080/geoserver/rest/workspaces/hazard/coverages/earthquake_intensity_1hz10pc50.json",
        "name"=>"earthquake_intensity_1hz10pc50"})
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

