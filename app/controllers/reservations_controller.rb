class ReservationsController < ApplicationController
	require 'stripe'
	#before_action :set_reservation , :only => [:show, :edit, :update, :destroy]
	before_action :set_listing, :only => [:new, :create]
	before_filter :current_user

	def index
    # Get current user's listings
    @listings = @current_user.listings
    @reservations = []
    @requested_reservations = []
    @current_user = current_user
    @message = @current_user.messages.build

    # Get current user's reservations
    @listings.each do |listing|
      listing.reservations.requested.each do |requested_reservation|
        @requested_reservations << requested_reservation
      end

      @accepted_reservations = listing.reservations.accepted
      listing.reservations.each do |reservation|
        @reservations << reservation
      end
    end

    @reservations_ive_made = Reservation.where(:booker_id => @current_user.id)
	end



	def create
    @current_user = current_user
		@reservation = @listing.reservations.new(reservation_params)
    @reservation.booker_id = @current_user.id

		if @reservation.save

	    # Calculate amount of time
	    time = translate_time_to_hours(@reservation.period.end, @reservation.period.start)

	    # Update reservation status
	    
    	# User wants to approve the reservation first
    	@reservation.requested!

    	# Send Email to Renter
    	#ReservationMailer.reservation_accepted_email(@current_user, @reservation, time).deliver

    	# Send Email to Lender
    	#ReservationMailer.lender_reservation_confirmation_email(@reservation.listing.user.email, @current_user, @reservation, time).deliver

      # Create notification
      @reservation.create_activity :create, :owner => @current_user, :recipient => @listing.user

			flash[:notice] = "Your reservation was succesfully made."
			redirect_to reservations_path
		else
      flash[:notice] = "We weren't able to create your reservation request."
			redirect_to listing_path(@reservation.listing)
		end
	end



	def show
		@reservation = Reservation.find(params[:id])
	end


  def accept_reservation
    @reservation = Reservation.find(params[:id])
    @reservation.accepted!

    respond_to do |format|
      format.js { render :action => "accept_reservation" }
    end
  end

  def reject_reservation
    @reservation = Reservation.find(params[:id])
    @reservation.rejected!

    respond_to do |format|
      format.js { render :action => "reject_reservation" }
    end
  end



	private
		def reservation_params
			params.require(:reservation).permit(:purpose, :booker_id, rate_attributes: [:amount, :date_range], period_attributes: [:start, :end])
		end

		def set_reservation
			@reservation = Reservation.find(params[:id])
		end

		def set_listing
			@listing = Listing.find(params[:listing_id])
		end

		def translate_time_to_hours(endTime, startTime)
			totalHours = (endTime - startTime).to_i / 3600
		end

    def translate_time_to_days(endTime, startTime)
      totalDays = translate_time_to_hours(endTime, startTime) / 24
    end
end
