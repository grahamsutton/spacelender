class CardsController < ApplicationController

  before_filter :current_user

  def create
    token = params[:stripeToken]

    @current_user = current_user
    customer = Stripe::Customer.retrieve(@current_user.customer_token)
    card = customer.sources.create(:card => token)
    @card = @current_user.cards.create(:card_token => card.id, :last4 => params[:last4])

    if @card.save
      flash[:notice] = "Your card was succesfully saved."
      redirect_to transactions_path
    else
      flash[:alert] = "Could not save your card."
      redirect_to transactions_path
    end
  end

  def destroy
    @current_user = User.find(params[:user_id])
    #@cards = @current_user.cards.where()
    flash[:success] = "Successfully deleted your selected cards."
    redirect_to transactions_path(:d => "cards-on-file")
  end

  private
  def card_params
    params.require(:card).permit(:stripeToken)
  end

end
