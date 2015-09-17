class Invoice < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :listing

  attr_accessor :stripeToken, :reservation_token

  def reservation
    Reservation.find_by(:id => self.reservation_id)
  end
end
