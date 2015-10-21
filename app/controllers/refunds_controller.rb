class RefundsController < ApplicationController
  before_filter :current_user
  before_filter :require_login

  def new
    @invoice = Invoice.find(params[:invoice_id])
    @refund = @invoice.build_refund
    @reservation = @invoice.reservation
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])
    refundee_id = @invoice.payer_id
    @refund = @invoice.build_refund(refund_params)
    @refund.refundee_id = refundee_id
    refundee = User.find(refundee_id)

    # Stripe Refund
    refund = @invoice.refund_payment(refundee, refund_params[:reason])

    # Save the refund_token just in case
    @refund.refund_token = refund.id

    if @refund.save
      # Change status of the invoice
      @invoice.refunded!

      # Subtract the refund from the user's income balance
      refundee.update_column(:total_income, refundee.total_income - (refund.amount / 100).to_f)

      flash[:success] = "#{refundee.first_name} #{refundee.last_name} was successfully refunded #{@invoice.reservation.subtotal - @invoice.reservation.fee} for their original reservation at #{@invoice.reservation.listing.name}."
      redirect_to transactions_path
    else
      flash[:error] = "Please fix any errors before resubmitting: "
      render :new
    end
  end

  private
  def refund_params
    params.require(:refund).permit(:reason, :confirm_refund)
  end
end
