class ListingsController < ApplicationController
  require 'stripe'

  before_filter :current_user
  before_filter :set_new_message
  before_filter :require_login, :except => [:show, :search, :update, :edit]

  respond_to :html, :xml, :json

  def dashboard
    @current_user = current_user
    @renter_reservations = @current_user.reservations_as_renter
    @lender_reservations = @current_user.reservations_as_lender
    @stripe_merchant_account = @current_user.stripe_merchant_account
    @balance = Stripe::Balance.retrieve({ :stripe_account => @current_user.uid })

    if @current_user.picture.nil?
      @picture = Picture.new
    end

    # Get News Feed
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  # List all listings
  def index
    # Get current user's listings
    @listings = @current_user.listings
    @reservations = []

    # Get current user's reservations
    @listings.each do |listing|
      @requested_reservations = listing.reservations.requested
      @accepted_reservations = listing.reservations.accepted
      listing.reservations.each do |reservation|
        @reservations << reservation
      end
    end

    # Get Active and Inactive listings
    @activeListings = @listings.where(:active => true)
    @inactiveListings = @listings.where(:active => false)
  end


  def new
    @current_user = current_user

    # Get user's Stripe account
    @stripe_merchant_account = Stripe::Account.retrieve(@current_user.uid)

    @listing = Listing.new
    @listing.build_location
    @listing.periods.build
    @listing.rates.build
    @listing.pictures.build
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

      if @listing.always_available == "true"
        @listing.periods.first.start = nil
        @listing.periods.first.end = nil
      end

      # Save the listing
      if @listing.save
        flash[:notice] = @listing.always_available
        if params[:image]
            respond_to do |format|
              format.html { redirect_to listings_path }
              format.json { render :json => { :message => "success" } }
            end
        end
      else
        flash[:alert] = "Uh-oh! Something's off here: "
        respond_to do |format|
          format.html { render :new }
          format.json { render :json => { :message => "failure" } }
        end
      end
  end



  # Show a single Listing
  def show
    @listing = Listing.find(params[:id])

    if !current_user
      @new_user = User.new
    end

    # Build Reservation's sub-attributes
    @reservation = @listing.reservations.build
    @reservation.build_rate
    @reservation.build_period

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
    @listing = Listing.find(params[:id])
    if @listing.destroy
      flash[:danger] = "The listing \"#{@listing.name}\" was deleted."
      redirect_to "/listings?q=ml"
    end
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
      @favorited_listing = FavoritedListing.new
      @listings = Listing.search(params[:search].downcase)
      @results = Array.new
      @cityCoordinates = Geocoder.coordinates(params[:city])
      
      
      
      if !params[:city].nil? && params[:city] != ""
        @results = @listings.select { |listing| listing.location.distance_from(@cityCoordinates) < 50 }
      else
        @results = @listings
      end

      @listings_json = []

      @coordinates = @results.map do |listing|
        @listings_json << listing.as_json(:include => [:location, :pictures])
      end

      respond_with(@results)
  end



  # Deactivates a listing
  def deactivate
    @listing = Listing.find(params[:id])

    if @listing.update_column(:active, false)
      flash[:message] = "\"#{@listing.name}\" was deactivated."
      redirect_to "/listings?q=ml"
    else
      flash[:danger] = "\"#{@listing.name}\" could not be deactivated. Please contact us at support@spacelender.com if this problem keeps happening."
    end
  end



  # Reactivates a listing
  def reactivate
    @listing = Listing.find(params[:id])

    if @listing.update_column(:active, true)
      flash[:notice] = "\"#{@listing.name}\" was reactivated."
      redirect_to "/listings?q=ml"
    else
      flash[:danger] = "\"#{@listing.name}\" could not be reactivated. Please contact us at support@spacelender.com if this problem keeps happening."
    end
  end


  def update_stripe_account
    @current_user = current_user

    @stripe_merchant_account = @current_user.stripe_merchant_account

    @stripe_merchant_account.legal_entity.personal_address.line1 = params[:address_line_1]
    @stripe_merchant_account.legal_entity.personal_address.city = params[:city]
    @stripe_merchant_account.legal_entity.personal_address.state = params[:state]
    @stripe_merchant_account.legal_entity.personal_address.postal_code = params[:zip]
    @stripe_merchant_account.legal_entity.personal_address.country = params[:country]
    @stripe_merchant_account.legal_entity.dob.month = params[:dob_month]
    @stripe_merchant_account.legal_entity.dob.day = params[:dob_day]
    @stripe_merchant_account.legal_entity.dob.year = params[:dob_year]
    @stripe_merchant_account.tos_acceptance.ip = request.remote_ip
    @stripe_merchant_account.tos_acceptance.date = DateTime.now.strftime("%s")
    @stripe_merchant_account.external_accounts.create(:external_account => params[:stripeToken])

    if @stripe_merchant_account.save
      flash[:stripe_success_notice] = "Alright, you're all good to go!"
      redirect_to stripe_success_path
    else
      flash[:stripe_failure_notice] = "We weren't able to verify your account."
      redirect_to new_listing_path
    end
  end

  def account_updated
    @current_user = current_user
    @stripe_merchant_account = @current_user.stripe_merchant_account
  end

  def filter_search
  end

  
  private
  def listing_params
    params.require(:listing).permit(:id, :name, :description, :stripeToken, :always_available, location_attributes: [:street_address, :city, :state, :zip, :country], periods_attributes: [:start, :end], rates_attributes: [:amount, :date_range], pictures_attributes: [:image], reservations_attributes: [rate_attributes: [:amount, :date_range], period_attributes: [:start, :end]])
  end
end