class FavoritedListingsController < ApplicationController
  before_filter :current_user
  before_filter :require_login

  def create
    @current_user = current_user
    @listing = Listing.find_by(:token => favorited_listing_params[:listing_id])

    # Create bookmark
    @favorited_listing = FavoritedListing.new
    @favorited_listing.user_id = @current_user.id
    @favorited_listing.listing_id = @listing.id

    if @favorited_listing.save
      flash[:notice] = "Bookmarked!"

      respond_to do |format|
        format.js { render :action => "create" }
      end
    else
      flash.now[:alert] = "Unable to create bookmark."
    end
  end

  def destroy
    @current_user = current_user
    @listing = Listing.find_by(:token => favorited_listing_params[:listing_id])
    @favorited_listing = FavoritedListing.find_by(:user_id => @current_user.id, :listing_id => @listing.id)

    # Destroy bookmark
    if @favorited_listing.destroy
      @favorited_listing = FavoritedListing.new
      respond_to do |format|
        format.js { render :action => "destroy" }
      end
    end
  end

  private
  def favorited_listing_params
    params.require(:favorited_listing).permit(:listing_id)
  end
end
