class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    logged_in? && current_user.admin?
  end

  # Garante que o usuário esteja logado
  def require_user
    unless logged_in?
      flash[:alert] = "Você precisa estar logado para acessar essa área."
      redirect_to login_path
    end
  end

  # Garante que o usuário seja admin
  def require_admin
    unless admin?
      flash[:alert] = "Você não tem permissão para acessar essa área."
      redirect_to root_path
    end
  end
end
