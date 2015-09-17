class InvoicesController < ApplicationController
  include ApplicationHelper
  before_filter :current_user
  before_filter :require_login

  def new
    @invoice = Invoice.new
    @reservation = Reservation.find_by(:token => params[:token])
    @current_user = current_user
    @stripe_customer_account = @current_user.stripe_customer_account
    @cards = @stripe_customer_account.sources.all(:object => "card")
  end

  def create
    @current_user = current_user
    @reservation = Reservation.find_by(:token => invoice_params[:reservation_token])
    @listing = @reservation.listing
    @invoice = Invoice.new

    # User used a new card
    if params[:stripeToken]
      payment_token = params[:stripeToken]
      payment_method = payment_token

      # User wants to save the card
      if params[:store_card]
        customer = Stripe::Customer.retrieve(@current_user.customer_token)
        card = customer.sources.create(:source => payment_token)
        @card = @current_user.cards.create(:card_token => card.id)
        payment_method = @card.card_token
      end

    else
      # User used an existing card on file

    end

    time = translate_time_to_hours(@reservation.period.end, @reservation.period.start)
    charge_amount = (@reservation.rate.amount * 100).to_i * time

    # Make the charge
    begin
      charge = Stripe::Charge.create({
        :amount => charge_amount,
        :currency => "usd",
        :card => payment_method,
        :description => "Test Charge",
        :application_fee => ((charge_amount) * ENV['spacelender_application_fee'].to_f).to_i
      },
      {
        :stripe_account => @listing.user.uid
      })

      # Mark reservation as PAID
      @reservation.paid!
      
    rescue Stripe::CardError => e
      flash[:notice] = "Your card was declined. Please provide an acceptable card."
      render :new
    end

    @invoice = Invoice.new(:reservation_id => @reservation.id, :payer_id => @current_user.id, :receiver_id => @listing.user.id, :amount => charge_amount)

    if @invoice.save
      # Create notification
      @invoice.create_activity :create, :owner => @current_user, :recipient => @listing.user, :parameters => { :total => @reservation.subtotal - @reservation.fee }

      flash[:notice] = "Your payment was succesfully processed."
      redirect_to dashboard_path
    else
      flash[:notice] = "Invoice was not generated successfully."
      redirect_to dashboard_path
    end

  end


  private
  def invoice_params
    params.require(:invoice).permit(:stripeToken, :reservation_token, :card)
  end
end
