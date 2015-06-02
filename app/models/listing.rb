class Listing < ActiveRecord::Base
  belongs_to :user
  has_one :location, :dependent => :destroy
  has_many :rates, :dependent => :destroy

  accepts_nested_attributes_for :location, :rates
end
