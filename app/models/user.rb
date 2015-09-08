class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	enum :role => [:normal, :employee, :admin]

	# Associations
	has_many :listings, :dependent => :destroy
  has_many :cards, :dependent => :destroy
  has_one :picture, :dependent => :destroy

	# Validations
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_format_of :first_name, :with => /\A[^\(\)0-9]*\z/
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_format_of :last_name, :with => /\A[^\(\)0-9]*\z/
	validates :email, presence: true, confirmation: true, uniqueness: true
  validates_format_of :email, :with => /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/
	validates :password, confirmation: true, presence: true, length: { minimum: 8, maximum: 20 }
	validates :publishable_key, :uniqueness => true, :allow_blank => true
	validates :uid, :uniqueness => true, :allow_blank => true
	validates :access_code, :uniqueness => true, :allow_blank => true

  before_create :encrypt_password

	# Filters
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
