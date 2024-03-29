class ReservationMailer < ApplicationMailer
	include ApplicationHelper
	include Roadie::Rails::Automatic

	default from: "SpaceLender Team"

	def reservation_requested(user, reservation, time)
		get_details(user, reservation, time)
		mail(to: @user.email, subject: "You requested to reserve \"#{@reservation.listing.name}\"")
	end

	def reservation_accepted(user, reservation, time)
		get_details(user, reservation, time)
		mail(to: @user.email, subject: "You reserved \"#{reservation.listing.name}\" for #{ActionController::Base.helpers.distance_of_time_in_words(@reservation.period.start, @reservation.period.end).gsub('about ', '')}")
	end

	def lender_reservation_confirmation(lenders_email, renter, reservation, time)
		get_details(renter, reservation, time)
		mail(to: lenders_email, subject: "Reservation from #{renter.first_name} #{renter.last_name} has been confirmed and paid." )
	end

  def reservation_was_accepted(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: "Your requested reservation was accepted. - #{@reservation.listing.name}")
  end

	def get_details(user, reservation, time)
		@user = user
		@reservation = reservation
		@time = time
		@date_range_type = base_time(@reservation.rate.date_range)  #=> "hour", "day", "week", "month"
	end
end
