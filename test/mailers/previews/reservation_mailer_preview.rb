# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
	def reservation_email_preview
		ReservationMailer.reservation_accepted_email(User.first, Reservation.first, 3)
	end

	def lender_reservation_confirmation_email_preview
		ReservationMailer.lender_reservation_confirmation_email(Reservation.first.listing.user.email, User.first, Reservation.first, 3)
	end
end
