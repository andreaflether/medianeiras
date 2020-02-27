class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception

  private
  
  def layout_by_resource
    if devise_controller?
      "devise_views"
    else
      "application"
    end
  end
end
