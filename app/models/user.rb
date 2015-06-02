class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	# Validations
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	# validates_confirmation_of :password

	# Filters
	before_save :encrypt_password

	attr_accessor :password_confirmation, :email_confirmation

	def encrypt_password
		self.password_salt = BCrypt::Engine.generate_salt
		self.password = BCrypt::Engine.hash_secret(password, self.password_salt)
	end

	def self.authenticate(email, password)
		user = User.where(email: email).first

		if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
			return user
		else
			return nil
		end
	end

	def slug_candidates
		[
			[:first_name, rand(100000..999999)],
			[:first_name, rand(100000..999999)],
			[:first_name, rand(100000..999999)]
		]
	end
end
