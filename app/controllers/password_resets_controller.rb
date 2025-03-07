# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
  def new
    # Exibe o formulário para o usuário informar o e-mail
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_password_reset_token!  # método no modelo User que gera o token
      PasswordResetMailer.with(user: @user).reset_email.deliver_now
      flash[:notice] = "Instruções para recuperação de senha foram enviadas para seu e-mail."
      redirect_to login_path
    else
      flash.now[:alert] = "Email não encontrado."
      render :new
    end
  end

  def edit
    # O token vem como :id na URL, e o e-mail como parâmetro
    @user = User.find_by(reset_token: params[:id], email: params[:email])
    if @user && @user.reset_sent_at > 2.hours.ago
      # Renderiza o formulário de redefinição de senha (edit.html.erb)
    else
      flash[:alert] = "Link inválido ou expirado."
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_by(reset_token: params[:id], email: params[:email])
    if @user && @user.update(user_params)
      # Opcionalmente, limpe os campos do token após a redefinição
      @user.update(reset_token: nil, reset_sent_at: nil)
      flash[:notice] = "Senha redefinida com sucesso."
      redirect_to login_path
    else
      flash.now[:alert] = "Não foi possível redefinir a senha."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
