# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Método para marcar que o usuário já alterou sua senha provisória
  def mark_password_as_changed!
    update(temporary: false)
  end

  def generate_password_reset_token!
    token = SecureRandom.urlsafe_base64
    update!(reset_token: token, reset_sent_at: Time.current)
  end

  # Verifica se o usuário é administrador
  def admin?
    self.admin
  end
end
  