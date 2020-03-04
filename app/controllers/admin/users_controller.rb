class Admin::UsersController < AdminController

  layout 'admin'

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuário atualizado com sucesso.'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, notice: 'Usuário apagado com sucesso.'
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :role, :email, :update_at, :created_at)
  end

  def authorize
    unless current_user.superadmin?
      redirect_to root_path, alert: 'Você não possui acesso a esta página.'
      return
    end
  end
end
