class UserMailer < ApplicationMailer
  include ApplicationHelper
  include Roadie::Rails::Automatic

  default from: "SpaceLender"

  def sign_up_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "SpaceLender - Confirm and Activate Your Account")
  end
end
