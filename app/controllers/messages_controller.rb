class MessagesController < ApplicationController
	before_filter :current_user
	before_filter :require_login

	def index
		@message = Message.new
		@messages = Message.all.limit(500)
	end
end
