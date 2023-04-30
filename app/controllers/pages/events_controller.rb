# frozen_string_literal: true

module Pages
  class EventsController < PagesController
    before_action :set_event, only: %i[show]

    def index
      @events = Event.includes([:location])
    end

    def show; end

    private

    def set_event
      @event = Event.friendly.find(params[:id])

      return redirect_to @event, status: :moved_permanently if request.path != event_path(@event)
    end
  end
end
