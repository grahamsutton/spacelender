class SessionsController < ApplicationController
  before_filter :current_user, :only => :destroy
  before_filter :redirect_if_logged_in, :only => :new

  respond_to :xml, :json, :html

  def new
  end

  def create
  	if @user = User.authenticate(params[:email], params[:password])
  		session[:user_id] = @user.id
  		flash[:notice] = "Welcome back, #{params[:r]}!"

      respond_with @user do |format|
        format.html { 
          if params[:r] == "yes"
            redirect_to request.referer
          else
            redirect_to dashboard_path
          end
        }

        format.json
      end
  	else
  		flash.now[:alert] = "Invalid username or password."
      respond_to do |format|
        format.html { render :new }
        format.json
      end
  	end
  end

  def destroy
  	session.delete(:user_id)
    flash[:notice] = "See ya later."
	  redirect_to root_path
  end
end
