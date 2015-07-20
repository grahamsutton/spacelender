class ReservationsController < ApplicationController
	require 'stripe'
	#before_action :set_reservation , :only => [:show, :edit, :update, :destroy]
	before_action :set_listing, :only => [:new, :create]

	def index
		@listing = Listing.includes(:reservations).find(params[:listing_id])
		@reservations = @listing.reservations.all
	end

	def create
		@reservation = @listing.reservations.new(reservation_params)

		if @reservation.save
			# After save, charge the card
			Stripe.api_key = "sk_test_FvxILVACVNCPAOYBuhJiVeby"
	    token = params[:stripeToken]

      begin
        charge = Stripe::Charge.create(
          :amount => (@reservation.rate.amount * 100).to_i,
          :currency => "usd",
          :source => token,
          :description => "Test Charge"
        )
      rescue Stripe::CardError => e
        flash.now[:alert] = "Your card was declined."
        
      end

			flash[:notice] = "Reservation was successfully created."
			redirect_to listings_path
		else

		end
	end

	private
		def reservation_params
			params.require(:reservation).permit(:total_hours, rate_attributes: [:amount, :date_range], period_attributes: [:start, :end])
		end

		def set_reservation
			@reservation = Reservation.find(params[:id])
		end

		def set_listing
			@listing = Listing.find(params[:listing_id])
		end

		def translate_amount

		end
end
