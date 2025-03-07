# app/mailers/password_reset_mailer.rb
class PasswordResetMailer < ApplicationMailer
    default from: 'no-reply@prefeitura.com'
  
    def reset_email
      @user = params[:user]
      @reset_url = edit_password_reset_url(@user.reset_token, email: @user.email)
      mail(to: @user.email, subject: 'Instruções para redefinição de senha')
    end
  end
  