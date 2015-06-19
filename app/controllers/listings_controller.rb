class ListingsController < ApplicationController
  before_filter :current_user
  before_filter :require_login, :except => [:show, :search]

  respond_to :html, :xml, :json

  # List all listings
  def index
    @listing = Listing.new
    @listing.build_location
    @listing.rates.build
    @listing.pictures.build

    @listings = @current_user.listings
  end

  # Display Listing form
  def new

  end
  
  # Process to create the Listing
  def create
      @listing = @current_user.listings.build(listing_params)

      if params[:image]
        params[:image].each do |image|
          @listing.pictures.build(:image => image)
        end
    end

      if @listing.save
        #flash[:notice] = "Welcome to SpaceLender"
        #redirect_to listings_path
        render json: { message: "success" }, :status => 200
      else
        flash.now[:alert] = "Uh-oh! Something's off here: "
        render :new
      end
  end

  # Show a single Listing
  def show
    @listing = Listing.find(params[:id])
    @payment = Payment.new
    @reservation = Reservation.new
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
      @listings = Listing.search(params[:search].downcase)
      @results = Array.new
      @cityCoordinates = Geocoder.coordinates(params[:city])

      @listings.each do |listing|
      	if Location.near(@cityCoordinates, 50, :order => :distance)
      		@results << listing
      	end
      end

      respond_with(@listings)
    end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description, location_attributes: [:street_address, :city, :state, :zip], rates_attributes: [:amount, :date_range], pictures_attributes: [:image])
  end
end