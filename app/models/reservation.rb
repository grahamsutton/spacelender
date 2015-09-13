class Reservation < ActiveRecord::Base
  enum :status => [:requested, :accepted, :rejected, :paid, :completed]

  before_create :generate_token
  
  belongs_to :listing
  has_one :rate, :as => :rateable, :dependent => :destroy
  # has_one :card, :dependent => :destroy
  has_one :period, :as => :periodic, :dependent => :destroy
  has_one :invoice, :dependent => :destroy

  accepts_nested_attributes_for :rate, :period

  def booker
    User.find(self.booker_id)
  end

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Reservation.exists?(token: random_token)
    end
  end
end
