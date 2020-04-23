class Admin::ActivitiesController < AdminController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  autocomplete :event, :location, :limit => 10
  before_action :counter, only: [:index]
  add_breadcrumb "Atividades", :activities_path
  before_action :find_resources, only: [:new, :create, :edit, :update]

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
    add_breadcrumb "Nova atividade", new_activity_path
    @activity = Activity.new
  end

  def find_resources
    @days = WeekDay.all
    @students = Student.includes([:person])
    @volunteers = Volunteer.includes([:person])
  end 

  # GET /activities/1/edit
  def edit
    add_breadcrumb "Editar informações de #{@activity.name}"
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
        flash.now[:error] = "Há erros no formulário. Verifique-os e tente novamente."
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
        format.html { redirect_to @activity, flash: { info: "Atividade atualizada com sucesso." } }
        format.json { render :show, status: :ok, location: @activity }
      else
        flash.now[:error] = "Há erros no formulário. Verifique-os e tente novamente."
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
                                     :ends_at, week_day_ids: [], student_ids: [], volunteer_ids: [])
  end
end
