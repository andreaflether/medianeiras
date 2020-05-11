class PagesController < ApplicationController
  layout 'pages'
  def index
    @main_activities = Activity.all.first(3)
    @next_events = Event.all.this_month
  end

  def contact 

  end 
end
