class UsersController < ApplicationController
	before_filter :current_user
  before_filter :set_new_message
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

		if @user.save
      UserMailer.sign_up_confirmation(@user).deliver_now
			flash[:notice] = "Thanks #{@user.first_name}! We sent you an email to activate your account at #{@user.email}."
			
      @user.create_stripe_customer
      @user.create_stripe_account

      # Adds in the Stripe credentials
      if @user.update(user_params)
        flash[:stripe_notice] = "Stripe credentials were successfully created."
      else
        flash[:stripe_notice] = "Stripe credentials could not be created."
      end

			redirect_to awaiting_activation_user_path(@user)
		else
			flash.now[:alert] = "Uh-oh! Something's off here: "
			render :new
		end
	end

	def edit
    @current_user = current_user
	end

	def update
    @current_user = current_user

		if @current_user.update(user_params)
			flash[:success] = "Your profile information was successfully updated."
			redirect_to user_path(@current_user)
		else
			flash[:error] = "Looks like there were some errors: "
			render :edit
		end
	end

  def confirm_email
    user = User.find_by(:confirm_token => params[:id])

    if user
      user.email_activate
      flash[:notice] = "Your account is now activated. \nPlease login to continue to your account."
      redirect_to login_path
    else
      flash[:alert] = "User does not exist."
      redirect_to registration_path
    end
  end

  def awaiting_activation
  end

	def change_password_path
	end

  def delete_profile_photo
    @current_user = current_user
    @picture = @current_user.build_picture

    if @current_user.picture.image.destroy
      respond_to do |format|
        format.js { render :action => "delete_profile_photo" }
      end
    else
      flash.now[:error] = "Something went wrong and we weren't able to delete your profile photo."
    end
  end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :email_confirmation, :customer_token, :uid, :access_code, :publishable_key, :tos, :birthdate, :base_city, :gender, :biography, picture_attributes: [:image], card_attributes: [:card_token])
	end
end
