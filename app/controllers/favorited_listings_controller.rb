class FavoritedListingsController < ApplicationController
  def create
    @favorited_listing = FavoritedListing.new
  end

  private
  def favorited_listing_params
    params.require(:favorited_listing).permit()
  end
end
