# frozen_string_literal: true

class PagesController < ApplicationController
  layout 'pages'
  def index
    @main_activities = Activity.all.first(3)
    @next_events = Event.all.happening_this_month
  end

  def contact; end
end
