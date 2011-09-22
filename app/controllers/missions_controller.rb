class MissionsController < AuthorizedController
  # GET /missions
  # GET /missions.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @missions }
    end
  end

  # GET /missions/1
  # GET /missions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission }
    end
  end

  # GET /missions/new
  # GET /missions/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission }
    end
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions
  # POST /missions.json
  def create
    respond_to do |format|
      if @mission.save
        format.html { redirect_to @mission, notice: t('mission.created') }
        format.json { render json: @mission, status: :created, location: @mission }
      else
        format.html { render action: "new" }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.json
  def update
    respond_to do |format|
      if @mission.update_attributes(params[:mission])
        format.html { redirect_to @mission, notice: t('mission.updated') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  def destroy
    @mission.destroy

    respond_to do |format|
      format.html { redirect_to missions_url }
      format.json { head :ok }
    end
  end
end
