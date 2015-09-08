class Card < ActiveRecord::Base
  belongs_to :user

  attr_accessor :stripeToken
end
