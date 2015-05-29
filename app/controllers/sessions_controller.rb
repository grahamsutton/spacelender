class SessionsController < ApplicationController
  before_filter :current_user, :only => :destroy
  def new
  end

  def create
  	if @user = User.authenticate(params[:username], params[:password])
  		session[:user_id] = @user.id
  		flash[:notice] = "Welcome back, #{@user.username}!"
  		redirect_to root_path
  	else
  		flash.now[:alert] = "Invalid username or password."
  		render :new
  	end
  end

  def destroy
    @name = @current_user.username
  	session.delete(:user_id)
	  redirect_to root_path, :notice => "See ya, #{@name}!"
  end
end
