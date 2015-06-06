class ListingsController < ApplicationController
	before_filter :current_user
	before_filter :require_login, :except => [:show, :search]

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
	      redirect_to listings_path
	    else
	      flash.now[:alert] = "Uh-oh! Something's off here: "
	      render :new
	    end
	end

	# Show a single Listing
	def show
		@listing = Listing.find(params[:id])
		@message = Message.new
	end

	# Update a Listing
	def update
    
	end

	# Delete a Listing
	def destroy

	end
	
	def findnearme
	  result = request.location
	  flash[:notice] = "#{result.ip}"
	end
	
	# search method
  def search
    @listings = Listing.search(params[:search])
    @search = params[:search].downcase
  end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description, location_attributes: [:street_address, :city, :state, :zip], rates_attributes: [:amount, :date_range], pictures_attributes: [:image])
  end
end
