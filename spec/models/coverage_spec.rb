require 'spec_helper'

describe Coverage do
  it "should have a base_url and layername" do
    c = Coverage.new("http://aifdr.nomad-labs.dyndns.org/geoserver/wcs?", "nurc:Arc_Sample")
    c.base_url.should == "http://aifdr.nomad-labs.dyndns.org/geoserver/wcs?"
    c.layername.should == "nurc:Arc_Sample"
  end
end