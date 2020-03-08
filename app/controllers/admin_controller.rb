class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize
  layout 'admin'

  def index
  end

  def counter
    @activities_count = Activity.all.count
    @events_count = Event.all.count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def authorize
    unless current_user.admin?
      redirect_to new_user_session_path
      return
    end
  end
end
