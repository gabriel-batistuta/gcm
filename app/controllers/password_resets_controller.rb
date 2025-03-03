# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
    def new
      # Exibe o formulário para o usuário informar o email
    end
  
    def create
      @user = User.find_by(email: params[:email])
      if @user
        # Aqui você implementaria o envio de um email com instruções para redefinir a senha
        flash[:notice] = "Instruções para recuperação de senha foram enviadas para seu e-mail."
        redirect_to login_path
      else
        flash.now[:alert] = "Email não encontrado."
        render :new
      end
    end
  end
  