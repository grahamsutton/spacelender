class Reservation < ActiveRecord::Base
  include PublicActivity::Common

  enum :status => [:requested, :accepted, :rejected, :paid, :completed]

  before_create :generate_token
  before_destroy :destroy_activities
  
  belongs_to :listing
  has_one :rate, :as => :rateable, :dependent => :destroy
  # has_one :card, :dependent => :destroy
  has_one :period, :as => :periodic, :dependent => :destroy
  has_one :invoice, :dependent => :destroy

  accepts_nested_attributes_for :rate, :period

  def booker
    User.find(self.booker_id)
  end

  def subtotal
    translate_time_to_hours(self.period.end, self.period.start) * self.rate.amount
  end

  # Includes Stripe's fee
  def fee
    fee = (self.subtotal * (ENV['spacelender_application_fee'].to_f + 0.029) + 0.30)
  end

  def translate_time_to_hours(endTime, startTime)
    totalHours = (endTime - startTime).to_i / 3600
  end

  def destroy_activites
    PublicActivity::Activity.where(:owner_id => self.id).destroy_all
  end

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Reservation.exists?(token: random_token)
    end
  end
end
