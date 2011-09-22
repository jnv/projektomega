class MissionAttendancesController < AuthorizedController
  # GET /mission_attendances
  # GET /mission_attendances.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mission_attendances }
    end
  end

  # GET /mission_attendances/1
  # GET /mission_attendances/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission_attendance }
    end
  end

  # GET /mission_attendances/1/edit
  def edit
  end

  # PUT /mission_attendances/1
  # PUT /mission_attendances/1.json
  def update
    respond_to do |format|
      if @mission_attendance.update_attributes(params[:mission_attendance])
        format.html { redirect_to @mission_attendance, notice: 'Mission attendance was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission_attendance.errors, status: :unprocessable_entity }
      end
    end
  end
end
