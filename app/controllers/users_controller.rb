# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :require_user, only: [:edit_password, :update_password]
  
    def new
      @user = User.new
    end
  
    def create
      # Geralmente o admin cadastra o usuário com uma senha provisória
      @user = User.new(user_params)
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
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
  
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
  