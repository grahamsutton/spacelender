class Location < ActiveRecord::Base
  belongs_to :listing

  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :country, presence: true
  validates :zip, presence: true, length: { is: 5 }, numericality: true

  geocoded_by :ambiguous_address
  after_validation :geocode

  def full_street_address
  	"#{self.street_address}, #{self.city}, #{self.state} #{self.zip}"
  end

  def ambiguous_address
  	"#{self.city}, #{self.state} #{self.zip}"
  end

  def very_ambiguous_address
    "#{self.city}, #{self.state}"
  end
end
