class Picture < ActiveRecord::Base
	belongs_to :listing

	has_attached_file :image, :styles => { :small => "150x150", :large => "320x240" },
					  :url => "/controllers/:style/:basename.:extension",
        			  :path => ":rails_root/app/assets/images/uploads/:style/:basename.:extension"
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
