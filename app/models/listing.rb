class Listing < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => [:slugged, :finders]

  belongs_to :user
  
  has_one :location, :dependent => :destroy
  has_many :rates, :as => :rateable, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :periods, :as => :periodic, :dependent => :destroy
  has_many :reservations, :dependent => :destroy

  accepts_nested_attributes_for :location, :periods, :pictures
  accepts_nested_attributes_for :rates,
                                :reject_if => proc { |attributes| attributes['amount'].blank? }
  
  # Search method
  def self.search(search)
     where(['lower(name) LIKE ? OR lower(description) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
  end

  def slug_candidates
    [
      :name
    ]
  end
end
