require "spec_helper"

describe HazardsController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/hazards" }.should route_to(:controller => "hazards", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/hazards/new" }.should route_to(:controller => "hazards", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/hazards/1" }.should route_to(:controller => "hazards", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/hazards/1/edit" }.should route_to(:controller => "hazards", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/hazards" }.should route_to(:controller => "hazards", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/hazards/1" }.should route_to(:controller => "hazards", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/hazards/1" }.should route_to(:controller => "hazards", :action => "destroy", :id => "1")
    end

  end
end
