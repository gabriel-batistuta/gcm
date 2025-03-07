# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # Apenas usuários NÃO admin devem trocar a senha provisória
      if user.temporary && !user.admin?
        flash[:alert] = "Por favor, altere sua senha provisória."
        redirect_to edit_password_path
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
