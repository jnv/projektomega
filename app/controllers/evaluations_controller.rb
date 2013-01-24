class EvaluationsController < AuthorizedController
  inherit_resources
  # # GET /evaluations
  # # GET /evaluations.json
  # def index
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @evaluations }
  #   end
  # end

  # # GET /evaluations/1
  # # GET /evaluations/1.json
  # def show
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @evaluation }
  #   end
  # end

  # # GET /evaluations/new
  # # GET /evaluations/new.json
  # def new
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @evaluation }
  #   end
  # end

  # # GET /evaluations/1/edit
  # def edit
  # end

  # # POST /evaluations
  # # POST /evaluations.json
  # def create
  #   @evaluation.author ||= current_user.character
  #   authorize! :create, @evaluation
  #   respond_to do |format|
  #     if @evaluation.save
  #       format.html { redirect_to @evaluation, notice: t('evaluation.created') }
  #       format.json { render json: @evaluation, status: :created, location: @evaluation }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @evaluation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PUT /evaluations/1
  # # PUT /evaluations/1.json
  # def update
  #   respond_to do |format|
  #     if @evaluation.update_attributes(params[:evaluation])
  #       format.html { redirect_to @evaluation, notice: t('evaluation.updated') }
  #       format.json { head :ok }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @evaluation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

end
