class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
      #if: Proc.new { |c| c.request.format =~ %r{application/json} }

  def current_user
  	  return unless session[:user_id]
  	  @current_user ||= User.find(session[:user_id])
  end

  def check_if_stripe_is_connected?
    @current_user = current_user

    if @current_user.publishable_key && @current_user.provider && @current_user.uid && @current_user.access_code
      return true
    else
      return false
    end
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
  
  def request_ip
    if Rails.env.development? && params[:ip]
      params[:ip]
    else
      request.remote_ip
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
