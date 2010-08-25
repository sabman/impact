require 'spec_helper'

describe ExposuresController do

  def mock_exposure(stubs={})
    @mock_exposure ||= mock_model(Exposure, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all exposures as @exposures" do
      Exposure.stub(:all) { [mock_exposure] }
      get :index
      assigns(:exposures).should eq([mock_exposure])
    end
  end

  describe "GET show" do
    it "assigns the requested exposure as @exposure" do
      Exposure.stub(:find).with("37") { mock_exposure }
      get :show, :id => "37"
      assigns(:exposure).should be(mock_exposure)
    end
  end

  describe "GET new" do
    it "assigns a new exposure as @exposure" do
      Exposure.stub(:new) { mock_exposure }
      get :new
      assigns(:exposure).should be(mock_exposure)
    end
  end

  describe "GET edit" do
    it "assigns the requested exposure as @exposure" do
      Exposure.stub(:find).with("37") { mock_exposure }
      get :edit, :id => "37"
      assigns(:exposure).should be(mock_exposure)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created exposure as @exposure" do
        Exposure.stub(:new).with({'these' => 'params'}) { mock_exposure(:save => true) }
        post :create, :exposure => {'these' => 'params'}
        assigns(:exposure).should be(mock_exposure)
      end

      it "redirects to the created exposure" do
        Exposure.stub(:new) { mock_exposure(:save => true) }
        post :create, :exposure => {}
        response.should redirect_to(exposure_url(mock_exposure))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved exposure as @exposure" do
        Exposure.stub(:new).with({'these' => 'params'}) { mock_exposure(:save => false) }
        post :create, :exposure => {'these' => 'params'}
        assigns(:exposure).should be(mock_exposure)
      end

      it "re-renders the 'new' template" do
        Exposure.stub(:new) { mock_exposure(:save => false) }
        post :create, :exposure => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested exposure" do
        Exposure.should_receive(:find).with("37") { mock_exposure }
        mock_exposure.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :exposure => {'these' => 'params'}
      end

      it "assigns the requested exposure as @exposure" do
        Exposure.stub(:find) { mock_exposure(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:exposure).should be(mock_exposure)
      end

      it "redirects to the exposure" do
        Exposure.stub(:find) { mock_exposure(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(exposure_url(mock_exposure))
      end
    end

    describe "with invalid params" do
      it "assigns the exposure as @exposure" do
        Exposure.stub(:find) { mock_exposure(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:exposure).should be(mock_exposure)
      end

      it "re-renders the 'edit' template" do
        Exposure.stub(:find) { mock_exposure(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested exposure" do
      Exposure.should_receive(:find).with("37") { mock_exposure }
      mock_exposure.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the exposures list" do
      Exposure.stub(:find) { mock_exposure }
      delete :destroy, :id => "1"
      response.should redirect_to(exposures_url)
    end
  end

end
