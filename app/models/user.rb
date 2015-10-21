class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	enum :role => [:normal, :employee, :admin]
  enum :gender => [:male, :female]

	# Associations
	has_many :listings, :dependent => :destroy
  has_many :cards, :dependent => :destroy
  has_many :favorited_listings, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_one :picture, :as => :imageable, :dependent => :destroy

	# Validations
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_format_of :first_name, :with => /\A[^\(\)0-9]*\z/
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_format_of :last_name, :with => /\A[^\(\)0-9]*\z/
	validates :email, presence: true, confirmation: true, uniqueness: true
  validates_format_of :email, :with => /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/
	validates :password, confirmation: true, presence: true, length: { minimum: 8, maximum: 20 }, :on => :create
	validates :publishable_key, :uniqueness => true, :allow_blank => true
	validates :uid, :uniqueness => true, :allow_blank => true
	validates :access_code, :uniqueness => true, :allow_blank => true
  validates :tos, :acceptance => {:accept => true, :message => "You must accept the Terms of Service and Stripe Connect Platform Agreement" }

  before_save :encrypt_password, :if => :password_changed?
  before_create :generate_confirmation_token

  accepts_nested_attributes_for :picture

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

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(
      description: "#{self.first_name} #{self.last_name}'s customer account.",
      email: self.email
    )
    self.customer_token = customer.id
  end

  def create_stripe_account
    account = Stripe::Account.create({
      :country => "US",
      :managed => true,
      :email => self.email,
      :legal_entity => {
        :type => "individual",
        :business_name => "#{self.first_name} #{self.last_name}",
        :first_name => self.first_name,
        :last_name => self.last_name,
        :address => {
          :country => "US"
        }
      }
    })

    self.uid = account.id
    self.access_code = account.keys.secret
    self.publishable_key = account.keys.publishable
  end

  def stripe_merchant_account
    Stripe::Account.retrieve(self.uid)
  end

  def stripe_customer_account
    Stripe::Customer.retrieve(self.customer_token)
  end

  def latest_news
    (self.listings + self.reservations).sort{| a, b | a.created_at <=> b.created_at}
  end

  def reservations_as_renter
    Reservation.where(:booker_id => self.id)
  end

  def reservations_as_lender
    reservations = []
    self.listings.each do |listing|
      listing.reservations.each do |reservation|
        reservations << reservation
      end
    end

    reservations
  end

	def slug_candidates
		[
			[:first_name, rand(100000..999999)],
			[:first_name, rand(100000..999999)],
			[:first_name, rand(100000..999999)]
		]
	end

  protected
  def generate_confirmation_token
    self.confirm_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(confirm_token: random_token)
    end
  end
end
