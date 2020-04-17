class Admin::ActivitiesController < AdminController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :days_to_s, only: [:create]
  autocomplete :event, :location, :limit => 10
  before_action :counter, only: [:index]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    @week_days = [['1', 'Segunda'], ['2', 'Terça'], ['3', 'Quarta'], ['4', 'Quinta'], 
    ['5', 'Sexta'], ['6', 'Sábado'], ['7', 'Domingo']]
  end

  # GET /activities/1/edit
  def edit

  end

  # POST /activities
  # POST /activities.json
  def create

    @activity = Activity.new(activity_params)
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
      params.require(:activity).permit(:name, :description, :location, :max_capacity, :days, :time_schedule)
    end

    def days_to_s
      unless params[:activity][:days].blank?
        params[:activity][:days] = params[:activity][:days].join(', ')
      end
    end
end
