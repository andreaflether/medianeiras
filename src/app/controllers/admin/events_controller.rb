class Admin::EventsController < AdminController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Eventos', :events_path

  def calendar
    add_breadcrumb 'Calendário'
  end 

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.includes([:location])
  end

  def show
    add_breadcrumb @event.title
  end

  def new
    add_breadcrumb 'Cadastrar Evento', new_event_path
    
    @event = Event.new  
  end

  def edit
    add_breadcrumb 'Editar Evento'
  end

  def create
    add_breadcrumb 'Cadastrar Evento'
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Evento criado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else    
        flash.now[:error] = 'Há erros no formulário. Verifique-os e tente novamente.'
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    add_breadcrumb 'Editar Evento'
    respond_to do |format|
      if @event.update(event_params)
        flash[:info] = 'Evento atualizado com sucesso!'
        format.html { redirect_to @event }
        format.json { render :show, status: :ok, location: @event }
      else
        flash.now[:error] = 'Há erros no formulário. Verifique-os e tente novamente.'
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
    params.require(:event).permit(:title, :description, :start_date, :end_date, :location_id)
  end
end
