require "spec_helper"

describe Exposure do
  it "should return all availalbe layers" do
    Exposure.layers.should include({
      "href"=>"http://www.aifdr.org:8080/geoserver/rest/workspaces/exposure/coverages/population_2010.json", 
      "name"=>"population_2010"})
  end
  
  it "should return all layernames as an array" do
    Exposure.layernames.class.should == Array
    Exposure.layernames.should include("population_2010")
  end

end
