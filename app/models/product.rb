class Product < ActiveRecord::Base
	enum status: %w(featured newer normal)

	validates_presence_of :name, :description

	before_validation :default_status

	def default_status
		self.status = :normal if status.blank?
	end

	def self.search(search)
		if search
			where('name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
		else
			all
		end
	end
end
