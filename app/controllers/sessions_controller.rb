class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login realizado com sucesso!"
      redirect_to root_path
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout efetuado com sucesso."
    redirect_to login_path
  end
end
