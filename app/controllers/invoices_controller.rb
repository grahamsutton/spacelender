class InvoicesController < ApplicationController
  require 'stripe'
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
    @invoice = @reservation.build_invoice
    @stripe_customer_account = @current_user.stripe_customer_account
    payment_method = ""

    if @reservation.rate.hourly?
      time = translate_time_to_hours(@reservation.period.end, @reservation.period.start)
    elsif @reservation.rate.daily?
      time = translate_time_to_days(@reservation.period.end, @reservation.period.start)
    end
    charge_amount = (@reservation.rate.amount * 100).to_i * time

    payment_setup = @invoice.set_payment_setup(@current_user, params[:stripeToken], params[:save_card], invoice_params[:card])

    # Make the charge
    begin
      charge = @invoice.submit_charge(charge_amount, payment_setup)

      # Mark reservation as PAID
      @reservation.paid!

      # Update Total Income column
      @listing.user.update_column(:total_income, @listing.user.total_income += (@reservation.subtotal - @reservation.fee))

      @invoice = @reservation.build_invoice(:reservation_id => @reservation.id, :payer_id => @current_user.id, :receiver_id => @listing.user.id, :amount => charge_amount, :card_last4 => params[:card_last4], :fee => @reservation.fee, :charge => charge.id)
      
    rescue Stripe::CardError => e
      flash[:notice] = "Your card was declined. Please provide an acceptable card."
      render :new
    end


    if @invoice.save
      # Create notification
      @invoice.create_activity :create, :owner => @current_user, :recipient => @listing.user, :parameters => { :total => @reservation.subtotal - @reservation.fee }

      flash[:notice] = "Your payment was succesfully processed."
      redirect_to dashboard_path
    else
      flash[:notice] = "Invoice was not generated successfully."
      redirect_to reservations_path
    end
  end

  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end


  private
  def invoice_params
    params.require(:invoice).permit(:stripeToken, :reservation_token, :card_last4, :card)
  end
end
