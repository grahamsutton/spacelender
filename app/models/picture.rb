class Picture < ActiveRecord::Base
	belongs_to :imageable, :polymorphic => true

	has_attached_file :image, 
					  :s3_host_alias => "s3-us-west-1.amazonaws.com/spacelender-pics", 
					  :url => ":s3_alias_url", 
					  :path => "pictures/:class/:id.:style.:extension",
					  :styles => {
					      :thumb=> "100x100#",
					      :large => "1400x1400>"
					  }
					  
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
