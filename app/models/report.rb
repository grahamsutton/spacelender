class Report < ActiveRecord::Base
  belongs_to :listing

  validates :reason, presence: true

  before_create :generate_token

  protected
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Report.exists?(token: random_token)
    end
  end
end
