# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  
    # Método para marcar que o usuário já alterou sua senha provisória
    def mark_password_as_changed!
      update(temporary: false)
    end
  end
  