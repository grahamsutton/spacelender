class Reservation < ActiveRecord::Base
  belongs_to :listing
  has_one :rate, :as => :rateable, :dependent => :destroy
  # has_one :card, :dependent => :destroy
  has_one :period, :as => :periodic, :dependent => :destroy

  accepts_nested_attributes_for :rate, :period
  attr_accessor :start_date, :start_time, :end_time, :end_date
end
