class Picture < ActiveRecord::Base
	belongs_to :listing

	has_attached_file :image, 
					  :s3_host_alias => "s3-us-west-1.amazonaws.com/spacelender-pics", 
					  :url => ":s3_alias_url", 
					  :path => "pictures/:class/:id.:style.:extension",
					  :styles => {
					      :thumb=> "100x100#",
					      :small  => "300x300>",
                :medium => "600x600>",
					      :large => "1400x1400>"
					  }
					  
  	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
