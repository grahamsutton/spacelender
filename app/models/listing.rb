class Listing < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => [:slugged, :finders]

  belongs_to :user
  
  has_one :location, :dependent => :destroy
  has_many :rates, :dependent => :destroy
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :location, :rates, :pictures

  def slug_candidates
    [
      :name
    ]
  end
end
