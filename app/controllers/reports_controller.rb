class ReportsController < ApplicationController
  before_filter :current_user
  before_filter :require_login

  def new
    @listing = Listing.find(params[:listing_id])
    @report = @listing.reports.build
  end

  def create
    @current_user = current_user
    @listing = Listing.find(params[:listing_id])
    @report = @listing.reports.build(report_params)

    if @report.save
      UserMailer.submit_report(@current_user, @report).deliver_now
      flash[:success] = "You report was succesfully submitted."
      redirect_to submitted_report_path(@report.token)
    else
      flash[:error] = "Please fix errors: "
      render :new
    end
  end

  def submitted
    @report = Report.find_by(:token => params[:token])
  end

  private
  def report_params
    params.require(:report).permit(:reason)
  end
end
