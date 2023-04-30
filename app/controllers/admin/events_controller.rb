# frozen_string_literal: true

module Admin
  class EventsController < AdminController
    before_action :set_event, only: %i[show edit update destroy]

    def calendar; end

    def index
      @q = Event.ransack(params[:q])
      @events = @q.result.includes([:location])
    end

    def show; end

    def new
      @event = Event.new
    end

    def edit; end

    def create
      sanitize_scheduled_for

      @event = Event.new(event_params)

      if @event.save
        redirect_to([:admin, @event], notice: t('create', scope: 'controllers.messages.admin.events'))
      else
        flash.now[:error] = t('general_error', scope: 'controllers.messages')
        render :new
      end
    end

    def update
      sanitize_scheduled_for

      if @event.update(event_params)
        redirect_to([:admin, @event], notice: t('update', scope: 'controllers.messages.admin.events'))
      else
        flash.now[:error] = t('general_error', scope: 'controllers.messages')
        render :edit
      end
    end

    def destroy
      @event.destroy
      redirect_to admin_events_url, notice: t('controllers.admin.events.destroy')
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def sanitize_scheduled_for
      scheduled_for = event_params[:scheduled_for]
      params[:event][:scheduled_for] = Date.parse(scheduled_for) if scheduled_for.present?
    end

    def event_params
      params.require(:event).permit(:title, :description, :scheduled_for, :starts_at, :ends_at,
                                    :location_id, :location_selection_type,
                                    location_attributes: %i[id description address])
    end
  end
end
