class ListingsController < ApplicationController
	before_filter :current_user

	def new
		@listing = Listing.new
	end
end
