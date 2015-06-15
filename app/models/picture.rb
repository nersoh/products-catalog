class Picture < ActiveRecord::Base
	belongs_to :product

	has_attached_file :image, styles: {:thumb => "100x100", :small => "200x200", 
																			:medium => "300x300"}, default_url: "/no_product_image.gif"
	
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }																			
end
