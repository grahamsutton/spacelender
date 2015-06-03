class Listing < ActiveRecord::Base
  belongs_to :user
  
  has_one :location, :dependent => :destroy
  has_many :rates, :dependent => :destroy
  has_many :pictures, :as => :imageable

  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  accepts_nested_attributes_for :location, :rates, :pictures
end
