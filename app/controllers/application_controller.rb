class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	  return unless session[:user_id]
  	  @current_user ||= User.find(session[:user_id])
  end

  def require_login
  	  if !current_user
  	  	flash[:notice] = "Please login before continuing."
  	  	redirect_to login_path
  	  end
  end

  def redirect_if_logged_out
    if current_user.nil?
      redirect_to root_path
    else
      return true
    end
  end

  def redirect_if_logged_in
    if current_user.nil?
      return true
    else
      redirect_to root_path
    end
  end
end
