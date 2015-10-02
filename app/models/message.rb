class Message < ActiveRecord::Base
  belongs_to :user

  before_create :generate_token

  attr_accessor :receiver, :stem, :thread

  def original_message(message_token)
    Message.find_by(:token => message_token)
  end

  def latest_message(message_token)
    Message.where(:reply => message_token).order("created_at DESC").first
  end

  def self.inbox_messages(user)
    Message.where(:receiver_id => user.id).order("created_at DESC")
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Message.exists?(token: random_token)
    end
  end
end
