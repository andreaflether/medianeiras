# frozen_string_literal: true

class PagesController < ApplicationController
  layout 'pages'

  def index
    @main_activities = Activity.first(3)
    @next_events = Event.happening_this_month
                        .includes([:location])
                        .first(5)
  end

  def about; end

  def activities; end

  def partners; end

  def events; end

  def contact; end
end
