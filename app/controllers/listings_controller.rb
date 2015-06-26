class ListingsController < ApplicationController
  before_filter :current_user
  before_filter :require_login, :except => [:show, :search]

  respond_to :html, :xml, :json

  # List all listings
  def index
    @listing = Listing.new
    @listing.build_location
    @listing.periods.build
    @listing.rates.build
    @listing.pictures.build

    @listings = @current_user.listings
  end

  # Display Listing form
  def edit
    @listing = Listing.find(params[:id])
    @coordinate = [{ :lat => @listing.location.latitude, :lng => @listing.location.longitude }]
    @coordinate = @coordinate.to_json
  end
  
  # Process to create the Listing
  def create
      @listing = @current_user.listings.build(listing_params)

      # If images selected, upload them to DB and S3
      if params[:image]
          params[:image].each do |image|
            @listing.pictures.build(:image => image)
          end
      end

      # Save the listing
      if @listing.save
        flash[:notice] = "Your listing #{@listing.name} was added successfully."
        if params[:image]
           render json: { message: "success" }, :status => 200
        else
          # Redirects to "My Listings" tab
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
      @listing = Listing.find(params[:id])
    
      # If images selected, upload them to DB and S3
      if params[:image]
          params[:image].each do |image|
            @listing.pictures.build(:image => image)
          end
      end

      if @listing.update(listing_params)
        flash[:notice] = "Your listing #{@listing.name} was updated successfully."
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

  # Delete a Listing
  def destroy

  end
  
  def findnearme
      Geocoder.configure(:timeout => 40)
      @listings = Listing.all
      @location = Array.new
      location_info = Geocoder.search(request_ip)

      location_info.each do |loc|
        @location.push(loc.latitude)
        @location.push(loc.longitude)
      end
     
      # Filter listings by distance
      @results = @listings.select { |listing| listing.location.distance_from(@location) < 50 }
     
      # Store coordinates for filtered results
      @coordinates = @results.map do |listing|
        { :lat => listing.location.latitude, :lng => listing.location.longitude }
      end
      
      # Get coordinates in json format
      @coordinates = @coordinates.to_json
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
    params.require(:listing).permit(:name, :description, location_attributes: [:street_address, :city, :state, :zip, :country], periods_attributes: [:start, :end], rates_attributes: [:amount, :date_range], pictures_attributes: [:image])
  end
end