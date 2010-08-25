class HazardsController < ApplicationController
  # GET /hazards
  # GET /hazards.xml
  def index
    @hazards = Hazard.layernames

    respond_to do |format|
      format.html { render :text => @hazards }
      format.xml  { render :xml => @hazards }
      format.json { render :json => @hazards.to_json}
    end
  end

  # GET /hazards/1
  # GET /hazards/1.xml
  def show
    @hazard = Hazard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hazard }
    end
  end

  # GET /hazards/new
  # GET /hazards/new.xml
  def new
    @hazard = Hazard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hazard }
    end
  end

  # GET /hazards/1/edit
  def edit
    @hazard = Hazard.find(params[:id])
  end

  # POST /hazards
  # POST /hazards.xml
  def create
    @hazard = Hazard.new(params[:hazard])

    respond_to do |format|
      if @hazard.save
        format.html { redirect_to(@hazard, :notice => 'Hazard was successfully created.') }
        format.xml  { render :xml => @hazard, :status => :created, :location => @hazard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hazard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hazards/1
  # PUT /hazards/1.xml
  def update
    @hazard = Hazard.find(params[:id])

    respond_to do |format|
      if @hazard.update_attributes(params[:hazard])
        format.html { redirect_to(@hazard, :notice => 'Hazard was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hazard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hazards/1
  # DELETE /hazards/1.xml
  def destroy
    @hazard = Hazard.find(params[:id])
    @hazard.destroy

    respond_to do |format|
      format.html { redirect_to(hazards_url) }
      format.xml  { head :ok }
    end
  end
end
