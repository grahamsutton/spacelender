class TransactionsController < ApplicationController

  before_filter :current_user
  before_filter :require_login

  def index
    @current_user = current_user
    @card = @current_user.cards.build

    # Get cards on file
    @cards = Stripe::Customer.retrieve(@current_user.customer_token).sources.all(:object => "card")
  end

  def new
    @transaction = Transaction.new
    #@reservation = Reservation(params[:id])
    @current_user = current_user
    @stripe_customer_account = @current_user.stripe_customer_account
    @cards = @stripe_customer_account.sources.all(:object => "card")
  end

  # private
  # def card_params
  #   params.require(:card).permit(:stripeToken)
  # end
end
