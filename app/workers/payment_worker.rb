class PaymentWorker
  include Sidekiq::Worker

  def perform(reservation_id, customer, card)
    reservation = Reservation.find(reservation_id)
    
    Stripe::Token.create({
      :customer => customer,
      :card => card
    },
    {
      :stripe_account => reservation.listing.user.uid
    })
  end
end