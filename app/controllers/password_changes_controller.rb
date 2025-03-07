class PasswordChangesController < ApplicationController
    before_action :authenticate_user
  
    def new
      @user = User.find(params[:user_id])
    end
  
    def create
      @user = User.find(params[:user_id])
      if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        @user.mark_password_as_changed!
        session[:user_id] = @user.id
        flash[:notice] = "Senha alterada com sucesso!"
        redirect_to dashboard_path
      else
        flash.now[:alert] = "Erro ao alterar a senha."
        render :new
      end
    end
  
    private
  
    def authenticate_user
      redirect_to login_path unless current_user
    end
  end
  