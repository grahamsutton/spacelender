class UsersController < ApplicationController
	before_filter :current_user

	# Home Page
	def index

	end

	# Sign Up
	def new
		@user = User.new
	end

	# Profile Viewing
	def show
		@user = User.find(params[:id])
	end

	# Registration Process
	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notice] = "Welcome to MiamiSoccerFinder, #{@user.username}"
			session[:user_id] = @user.id
			redirect_to root_path
		else
			flash.now[:alert] = "Uh-oh! Something's off here: "
			render :new
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :email, :email_confirmation)
	end
end
