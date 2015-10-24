class Listing < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => [:slugged, :finders]

  before_create :generate_token

  belongs_to :user
  
  has_one :location, :dependent => :destroy
  has_many :rates, :as => :rateable, :dependent => :destroy
  has_many :pictures, :as => :imageable, :dependent => :destroy
  has_many :periods, :as => :periodic, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :favorited_listings, :dependent => :destroy
  has_many :reports

  validates :name, presence: true, length: { minimum: 8, maximum: 120 }
  validates :description, presence: true, length: { minimum: 26, maximum: 4000 }

  accepts_nested_attributes_for :location, :periods, :pictures, :reservations
  accepts_nested_attributes_for :rates,
                                :reject_if => proc { |attributes| attributes['amount'].blank? }

  attr_accessor :stripeToken, :always_available
  
  # Search method
  def self.search(search)
    search_term = search
    where(['lower(name) LIKE ? OR lower(description) LIKE ?', "%#{search_term.downcase}%", "%#{search_term.downcase}%"])
  end

  def image_url
    self.image.url(:original)
  end

  def slug_candidates
    [
      :name
    ]
  end

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Listing.exists?(token: random_token)
    end
  end
end
