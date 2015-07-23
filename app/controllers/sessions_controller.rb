class SessionsController < ApplicationController
  before_filter :current_user, :only => :destroy
  before_filter :redirect_if_logged_in, :only => :new

  respond_to :xml, :json, :html

  def new
  end

  def create
  	if @user = User.authenticate(params[:email], params[:password])
  		session[:user_id] = @user.id
  		flash[:notice] = "Welcome back, #{@user.email}!"

      respond_with @user do |format|
        format.html { redirect_to listings_path }
        format.json
      end
  	else
  		flash.now[:alert] = "Invalid username or password."
  		render :new
  	end
  end

  def destroy
  	session.delete(:user_id)
    cookies.delete("js.stripe.com")
    flash[:notice] = "See ya later."
	  redirect_to root_path
  end
end
