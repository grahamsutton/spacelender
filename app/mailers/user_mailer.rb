class UserMailer < ApplicationMailer
  include ApplicationHelper
  include Roadie::Rails::Automatic

  default from: "SpaceLender"

  def sign_up_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "SpaceLender - Confirm and Activate Your Account")
  end

  def submit_report(user, report)
    @user = user
    @report = report

    mail(:to => "gsutton@spacelender.com", :subject => "New Report from #{@user.first_name} #{@user.last_name}")
  end
end
