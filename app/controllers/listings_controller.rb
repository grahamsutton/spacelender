class ListingsController < ApplicationController
	before_filter :current_user

	# List all listings
	def index
		@listings = @current_user.listings
	end

	# Display Listing form
	def new
		@listing = @current_user.listings.build
		@listing.build_location
		@listing.rates.build
		@listing.pictures.build
	end
	
	# Process to create the Listing
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

	# Show a single Listing
	def show

	end

	# Update a Listing
	def update

	end

	# Delete a Listing
	def destroy

	end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description, picture_attributes: [:imageable], location_attributes: [:street_address, :city, :state, :zip], rates_attributes: [:amount, :date_range])
  end
end
