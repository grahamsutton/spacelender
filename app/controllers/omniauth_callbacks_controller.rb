class OmniauthCallbacksController < ApplicationController
	before_filter :require_login
	before_filter :current_user

	def stripe_connect
		#raise request.env["omniauth.auth"].to_yaml

		if @current_user.update({
			provider: request.env["omniauth.auth"].provider,
			uid: request.env["omniauth.auth"].uid,
			access_code: request.env["omniauth.auth"].credentials.token,
			publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
		})

			flash[:notice] = "You're Stripe account is now connected!"
		else
			flash[:danger] = "Looks like you're trying to connect a Stripe account that is already in use by another SpaceLender account.
			\nIt is possible that a Stripe account may be currently signed in on your computer right now. Please Log Out of any Stripe accounts you may have open by
			\nvisiting https://www.stripe.com, and then try again."
		end

		redirect_to listings_path
	end
end
