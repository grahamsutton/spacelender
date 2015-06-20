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
        flash[:notice] = "Your listing #{@listing.name} was added successfully."
        if params[:image]
           render json: { message: "success" }, :status => 200
        else
          redirect_to "/listings?q=ml"
        end
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
    @coordinate = [{ :lat => @listing.location.latitude, :lng => @listing.location.longitude }]
    @coordinate = @coordinate.to_json
    
  end

  # Update a Listing
  def update
    
  end

  # Delete a Listing
  def destroy

  end
  
  def findnearme
     @listings = Listing.all
     @results = @listings.select { |listing| listing.location.distance_from(request.location.city) < 50 }
     
     render :text => request.location.city
  end
  
  # search method
  def search
    
      @listings = Listing.search(params[:search].downcase)
      @results = Array.new
      @cityCoordinates = Geocoder.coordinates(params[:city])
      
      if !params[:city].nil? && params[:city] != ""
        @results = @listings.select { |listing| listing.location.distance_from(@cityCoordinates) < 50 }
      else
        @listings.each do |listing|
          @results << listing
        end
      end
      
      @coordinates = @results.map do |listing|
        { :lat => listing.location.latitude, :lng => listing.location.longitude }
      end
      
      @coordinates = @coordinates.to_json
      
      respond_with(@results)
  end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description, location_attributes: [:street_address, :city, :state, :zip], rates_attributes: [:amount, :date_range], pictures_attributes: [:image])
  end
end