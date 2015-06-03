class ListingsController < ApplicationController
	before_filter :current_user

	def new
		@listing = @current_user.listings.build
		@listing.build_location
		@listing.rates.build
	end
	
	def create
	    @listing = @current_user.listings.build(listing_params)

	    if @listing.save
	      flash[:notice] = "Welcome to SpaceLender"
	      redirect_to root_path
	    else
	      flash.now[:alert] = "Uh-oh! Something's off here: "
	      render :new
	    end
	end
	
	def mylistings
	  @listings = @current_user.listings
	  
	end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description, location_attributes: [:street_address, :city, :state, :zip], rates_attributes: [:amount, :date_range])
  end
end
