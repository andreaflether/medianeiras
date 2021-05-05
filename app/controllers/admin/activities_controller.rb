# frozen_string_literal: true

module Admin
  class ActivitiesController < AdminController
    before_action :set_activity, only: %i[show edit update destroy]

    # GET /activities
    def index
      @activities = Activity.all
    end

    # GET /activities/1
    def show; end

    # GET /activities/new
    def new
      @activity = Activity.new
    end

    # GET /activities/1/edit
    def edit; end

    # POST /activities
    def create
      sanitize_closure_date
      @activity = Activity.new(activity_params)

      respond_to do |format|
        if @activity.save
          format.html { redirect_to @activity, notice: 'Atividade criada com sucesso!' }
          format.json { render :show, status: :created, location: @activity }
        else
          flash.now[:error] = 'Há erros no formulário. Verifique-os e tente novamente.'
          format.html { render :new }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /activities/1
    def update
      sanitize_closure_date
      respond_to do |format|
        if @activity.update(activity_params)
          format.html { redirect_to @activity, flash: { info: 'Atividade atualizada com sucesso.' } }
          format.json { render :show, status: :ok, location: @activity }
        else
          flash.now[:error] = 'Há erros no formulário. Verifique-os e tente novamente.'
          format.html { render :edit }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /activities/1
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

    def sanitize_closure_date
      closure_date = activity_params[:closure_date]
      params[:activity][:closure_date] = Date.parse(closure_date) if closure_date.present?
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :description, :location_id, :max_capacity, :starts_at,
                                       :ends_at, :display_image, :status, :location_selection_type,
                                       :closure_date, :closure_reason, :display_image_cache,
                                       location_attributes: %i[id description address],
                                       week_day_list: [], student_ids: [], volunteer_ids: [])
    end
  end
end
