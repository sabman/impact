require "spec_helper"

describe ExposuresController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/exposures" }.should route_to(:controller => "exposures", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/exposures/new" }.should route_to(:controller => "exposures", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/exposures/1" }.should route_to(:controller => "exposures", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/exposures/1/edit" }.should route_to(:controller => "exposures", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/exposures" }.should route_to(:controller => "exposures", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/exposures/1" }.should route_to(:controller => "exposures", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/exposures/1" }.should route_to(:controller => "exposures", :action => "destroy", :id => "1")
    end

  end
end
