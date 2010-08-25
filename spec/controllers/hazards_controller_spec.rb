require 'spec_helper'

describe HazardsController do

  def mock_hazard(stubs={})
    @mock_hazard ||= mock_model(Hazard, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all hazards as @hazards" do
      Hazard.stub(:all) { [mock_hazard] }
      get :index
      assigns(:hazards).should eq([mock_hazard])
    end
  end

  describe "GET show" do
    it "assigns the requested hazard as @hazard" do
      Hazard.stub(:find).with("37") { mock_hazard }
      get :show, :id => "37"
      assigns(:hazard).should be(mock_hazard)
    end
  end

  describe "GET new" do
    it "assigns a new hazard as @hazard" do
      Hazard.stub(:new) { mock_hazard }
      get :new
      assigns(:hazard).should be(mock_hazard)
    end
  end

  describe "GET edit" do
    it "assigns the requested hazard as @hazard" do
      Hazard.stub(:find).with("37") { mock_hazard }
      get :edit, :id => "37"
      assigns(:hazard).should be(mock_hazard)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created hazard as @hazard" do
        Hazard.stub(:new).with({'these' => 'params'}) { mock_hazard(:save => true) }
        post :create, :hazard => {'these' => 'params'}
        assigns(:hazard).should be(mock_hazard)
      end

      it "redirects to the created hazard" do
        Hazard.stub(:new) { mock_hazard(:save => true) }
        post :create, :hazard => {}
        response.should redirect_to(hazard_url(mock_hazard))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hazard as @hazard" do
        Hazard.stub(:new).with({'these' => 'params'}) { mock_hazard(:save => false) }
        post :create, :hazard => {'these' => 'params'}
        assigns(:hazard).should be(mock_hazard)
      end

      it "re-renders the 'new' template" do
        Hazard.stub(:new) { mock_hazard(:save => false) }
        post :create, :hazard => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested hazard" do
        Hazard.should_receive(:find).with("37") { mock_hazard }
        mock_hazard.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hazard => {'these' => 'params'}
      end

      it "assigns the requested hazard as @hazard" do
        Hazard.stub(:find) { mock_hazard(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:hazard).should be(mock_hazard)
      end

      it "redirects to the hazard" do
        Hazard.stub(:find) { mock_hazard(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(hazard_url(mock_hazard))
      end
    end

    describe "with invalid params" do
      it "assigns the hazard as @hazard" do
        Hazard.stub(:find) { mock_hazard(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:hazard).should be(mock_hazard)
      end

      it "re-renders the 'edit' template" do
        Hazard.stub(:find) { mock_hazard(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested hazard" do
      Hazard.should_receive(:find).with("37") { mock_hazard }
      mock_hazard.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the hazards list" do
      Hazard.stub(:find) { mock_hazard }
      delete :destroy, :id => "1"
      response.should redirect_to(hazards_url)
    end
  end

end
