class Invoice < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :listing

  attr_accessor :stripeToken, :reservation_token, :card_last4

  def reservation
    Reservation.find_by(:id => self.reservation_id)
  end

  def create_payment_token(customer, card)
    payment_method = Stripe::Token.create({
      :customer => customer,
      :card => card
    },
    {
      :stripe_account => reservation.listing.user.uid
    })

    payment_method
  end

  def submit_charge(charge_amount, payment_method)
    charge = Stripe::Charge.create({
      :amount => charge_amount,
      :source => payment_method,
      :currency => "usd",
      :description => "Test Charge",
      :statement_descriptor => "Reservation Charge",
      :application_fee => ((charge_amount) * ENV['spacelender_application_fee'].to_f).to_i
    },{
      :stripe_account => reservation.listing.user.uid
    })

    charge
  end

  def set_payment_setup(user, token, save_card, selected_card = nil)
    if token
      payment_token = token
      payment_method = payment_token

      if save_card
        card = user.stripe_customer_account.sources.create(:source => payment_token)
        card = user.cards.create(:card_token => card.id)
        payment_method = card.card_token
        payment_setup = self.create_payment_token(user.stripe_customer_account.id, payment_method)
      else
        payment_setup = token
      end
    else
      if !selected_card.nil?
        card = user.stripe_customer_account.sources.retrieve(selected_card)
        payment_setup = self.create_payment_token(user.stripe_customer_account.id, card.id)
      else
        payment_setup = false
      end
    end

    payment_setup
  end

end
