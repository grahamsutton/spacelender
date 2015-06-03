class Listing < ActiveRecord::Base
  belongs_to :user
  
  has_one :location, :dependent => :destroy
  has_many :rates, :dependent => :destroy
  has_many :pictures, :as => :pictureable

  # has_attached_file :image,
  #                     :storage => :s3,
  #                     :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  #   def s3_credentials
  #   	{:bucket => "spacelender", :access_key_id => "AKIAI4YTGPQPHYMTMT5Q", :secret_access_key => "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"}
  #   end

  accepts_nested_attributes_for :location, :rates, :pictures
end
