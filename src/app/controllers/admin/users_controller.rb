class Admin::UsersController < AdminController
  before_action :authorize
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  def show
  end

  def index
    @users = User.all
    add_breadcrumb "usuários", users_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuário atualizado com sucesso!'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path, notice: 'Usuário apagado com sucesso.'
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :role, :email, :update_at, :created_at)
  end

  def set_user 
    @user = User.find(params[:id])
  end 

  def authorize
    unless current_user.superadmin?
      redirect_to root_path, alert: 'Você não possui acesso a esta página.'
      return
    end
  end
end
