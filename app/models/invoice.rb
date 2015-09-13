class Invoice < ActiveRecord::Base
  belongs_to :listing

  attr_accessor :stripeToken, :reservation_token
end
