class User < ActiveRecord::Base
	enum role: %w(user admin)
	has_secure_password

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 200 },
										uniqueness: { case_sensitive: true },
										format: { with: EMAIL_REGEX }
	validates :password, presence: true, length: { minimum: 6 }, if: :password

	before_save { self.email = email.downcase }
	before_create { generate_token(:auth_token) }

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists? column => self[column]
	end
end
