class ReservationsController < ApplicationController
	require 'stripe'
	#before_action :set_reservation , :only => [:show, :edit, :update, :destroy]
	before_action :set_listing, :only => [:new, :create]
	before_filter :current_user

	def index
		@listing = Listing.includes(:reservations).find(params[:listing_id])
		@reservations = @listing.reservations.all
	end

	def create
		@reservation = @listing.reservations.new(reservation_params)

		if @reservation.save
			# After save, charge the card
			Stripe.api_key = ENV['stripe_api_key']
	    token = params[:stripeToken]

	    # Calculate amount of time
	    time = translate_time(@reservation, @reservation.period.end, @reservation.period.start)

	    # Update reservation status
	    @reservation.accepted!

      begin
        charge = Stripe::Charge.create({
          :amount => (@reservation.rate.amount * 100).to_i * time,
          :currency => "usd",
          :source => token,
          :description => "Test Charge",
          :application_fee => (((@reservation.rate.amount * 100).to_i * time) * ENV['spacelender_application_fee'].to_f).to_i
        },
        {
        	:stripe_account => @listing.user.uid
        })
      rescue Stripe::CardError => e
        flash.now[:alert] = "Your card was declined."
      end

			flash[:notice] = charge
			redirect_to listings_path
		else

		end
	end

	private
		def reservation_params
			params.require(:reservation).permit(rate_attributes: [:amount, :date_range], period_attributes: [:start, :end])
		end

		def set_reservation
			@reservation = Reservation.find(params[:id])
		end

		def set_listing
			@listing = Listing.find(params[:listing_id])
		end

		def translate_time(reservation, endTime, startTime)
			totalHours = (endTime - startTime).to_i / 3600
		end
end
