class UsersController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :destroy]
  before_action :require_user, only: [:edit_password, :update_password]
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.temporary = true # Define que a senha provisória precisa ser alterada
    if @user.save
      flash[:notice] = "Usuário criado com sucesso. Senha provisória cadastrada."
      redirect_to root_path
    else
      render :new
    end
  end

  # Página para alterar a senha no primeiro acesso
  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(password_params)
      @user.mark_password_as_changed!
      flash[:notice] = "Senha atualizada com sucesso!"
      redirect_to root_path
    else
      flash.now[:alert] = "Erro ao atualizar senha."
      render :edit_password
    end
  end

  # Ação para atualizar o usuário (tornar admin ou não)
  def update
    # @user é definido em set_user
    if current_user.admin?
      if @user.update(user_params)
        redirect_to users_path, notice: "Usuário atualizado com sucesso."
      else
        render :index, alert: "Erro ao atualizar o usuário."
      end
    else
      redirect_to root_path, alert: "Você não tem permissão para modificar este usuário."
    end
  end

  # Ação para apagar o usuário
  def destroy
    if current_user.admin? && current_user != @user
      @user.destroy
      redirect_to users_path, notice: "Usuário apagado com sucesso."
    else
      redirect_to users_path, alert: "Você não pode apagar seu próprio usuário."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "Apenas administradores podem cadastrar usuários."
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
