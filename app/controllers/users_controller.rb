class UsersController < ApplicationController
	before_filter :current_user
	before_filter :redirect_if_logged_in, :only => :new

	respond_to :html, :xml, :json

	# Home Page
	def index
		@user = User.new
	end

	# Sign Up
	def new
		@user = User.new
	end

	# Profile Viewing
	def show
		@user = User.find(params[:id])
		respond_with(@user)
	end

	# Registration Process
	def create
		@user = User.new(user_params)

		@user.encrypt_password

		if @user.save
			flash[:notice] = "Welcome to SpaceLender, #{@user.first_name}"
			session[:user_id] = @user.id
			redirect_to listings_path
		else
			flash.now[:alert] = "Uh-oh! Something's off here: "
			render :new
		end
	end

	def edit
	end

	def update
		if @current_user.update
			flash[:notice] = "Your profile information was successfully updated."
			redirect_to listings_path
		else
			flash[:notice] = "Looks like there were some errors: "
			render :edit
		end
	end

	def change_password_path
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :email_confirmation)
	end
end
