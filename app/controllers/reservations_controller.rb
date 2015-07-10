class ReservationsController < ApplicationController
	def create
		
	end

	private
	def reservation_params
		params.require(:reservation).permit()
	end
end
