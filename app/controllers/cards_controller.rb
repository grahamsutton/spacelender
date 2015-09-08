class CardsController < ApplicationController

  before_filter :current_user

  def create
    token = params[:stripeToken]

    @current_user = current_user
    customer = Stripe::Customer.retrieve(@current_user.customer_token)
    card = customer.sources.create(:source => token)
    @card = @current_user.cards.create(:card_token => card.id)

    if @card.save
      flash[:notice] = "Your card was succesfully saved."
      redirect_to transactions_path
    else
      flash[:alert] = "Could not save your card."
      redirect_to transactions_path
    end
  end

  private
  def card_params
    params.require(:card).permit(:stripeToken)
  end

end
