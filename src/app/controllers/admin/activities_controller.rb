class Admin::ActivitiesController < AdminController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  # before_action :days_to_s, only: [:create]
  autocomplete :event, :location, :limit => 10
  before_action :counter, only: [:index]
  before_action :selected_days, only: [:edit]
  add_breadcrumb "atividades", :activities_path

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    add_breadcrumb @activity.name
  end

  # GET /activities/new
  def new
    add_breadcrumb "nova atividade", new_activity_path
    @activity = Activity.new
    @days = WeekDay.all
  end


  # GET /activities/1/edit
  def edit
    add_breadcrumb "editar atividade"
    @days = WeekDay.all
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @days = WeekDay.all
    
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Atividade criada com sucesso!' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        puts field_error_message = instance.error_message
        format.html { redirect_to @activity, notice: 'Atividade atualizada com sucesso!' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Atividade apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def activity_params
    params.require(:activity).permit(:name, :description, :location, :max_capacity, :starts_at, 
                                     :ends_at, week_day_ids: [])
  end
end
