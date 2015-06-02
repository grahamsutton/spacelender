class ListingsController < ApplicationController
	before_filter :current_user

	def new
		@listing = Listing.new
		#@listing.build_location
	end
	
	def create
	    @listing = Listing.new(listing_params)

	    if @listing.save
	      flash[:notice] = "Welcome to SpaceLender"
	      redirect_to root_path
	    else
	      flash.now[:alert] = "Uh-oh! Something's off here: "
	      render :new
	    end
	end
  
  private
  def listing_params
    params.require(:listing).permit(:name, :description)
  end
end
