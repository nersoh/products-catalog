class Product < ActiveRecord::Base
	enum status: %w(featured newer normal)

	has_many :pictures, dependent: :destroy
	accepts_nested_attributes_for :pictures, 
																reject_if: proc { |attributes| attributes['image'].blank? },
																allow_destroy: true

	validates_presence_of :name, :description

	before_validation :default_status

	before_save :default_cover

	def default_status
		self.status = :normal if status.blank?
	end

	def default_cover
		self.pictures.build if self.pictures.blank?
	end

	def self.search(search)
		if search
			where('name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
		else
			all
		end
	end
end
