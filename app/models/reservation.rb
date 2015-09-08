class Reservation < ActiveRecord::Base
  enum :status => [:requested, :accepted, :rejected, :completed]
  
  belongs_to :listing
  has_one :rate, :as => :rateable, :dependent => :destroy
  # has_one :card, :dependent => :destroy
  has_one :period, :as => :periodic, :dependent => :destroy

  accepts_nested_attributes_for :rate, :period

  def booker
    User.find(self.booker_id)
  end
end
