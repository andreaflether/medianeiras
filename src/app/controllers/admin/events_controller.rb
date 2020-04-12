class Admin::EventsController < AdminController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  autocomplete :event, :location, :limit => 10
  add_breadcrumb "eventos", :events_path

  def calendar 

  end 
  def index
    @q = Event.ransack(params[:q])
    @events = @q.result
    # @events = Event.all
    # add_breadcrumb "eventos", events_path
  end


  def show
    add_breadcrumb "visualizar evento"
  end

  def new
    add_breadcrumb "novo evento", new_event_path
    
    @event = Event.new
    
  end

  def edit
    add_breadcrumb "editar evento"
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Evento criado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else
        
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Evento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Evento excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_date, :end_date, :location)
    end
end
