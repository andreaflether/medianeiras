class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize
  layout 'admin'
  add_breadcrumb 'Início', :root_path

  def index; end

  private

  def authorize
    unless current_user.admin?
      redirect_to root_path
      return
    end
  end
end
