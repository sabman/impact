class ExposuresController < ApplicationController
  # GET /exposures
  # GET /exposures.xml
  def index
    @exposures = Exposure.layernames

    respond_to do |format|
      format.html { render :text => @exposures  }
      format.xml  { render :xml => @exposures   }
      format.json { render :json => @exposures.to_json  }
    end
  end

  # GET /exposures/1
  # GET /exposures/1.xml
  def show
    @exposure = Exposure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exposure }
    end
  end

  # GET /exposures/new
  # GET /exposures/new.xml
  def new
    @exposure = Exposure.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exposure }
    end
  end

  # GET /exposures/1/edit
  def edit
    @exposure = Exposure.find(params[:id])
  end

  # POST /exposures
  # POST /exposures.xml
  def create
    @exposure = Exposure.new(params[:exposure])

    respond_to do |format|
      if @exposure.save
        format.html { redirect_to(@exposure, :notice => 'Exposure was successfully created.') }
        format.xml  { render :xml => @exposure, :status => :created, :location => @exposure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exposure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exposures/1
  # PUT /exposures/1.xml
  def update
    @exposure = Exposure.find(params[:id])

    respond_to do |format|
      if @exposure.update_attributes(params[:exposure])
        format.html { redirect_to(@exposure, :notice => 'Exposure was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exposure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exposures/1
  # DELETE /exposures/1.xml
  def destroy
    @exposure = Exposure.find(params[:id])
    @exposure.destroy

    respond_to do |format|
      format.html { redirect_to(exposures_url) }
      format.xml  { head :ok }
    end
  end
end
