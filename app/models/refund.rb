class Refund < ActiveRecord::Base
  belongs_to :invoice

  validates :reason, :presence => true
  validates_acceptance_of :confirm_refund, :message => "- Confirm Refund checkbox must be checked."

  attr_accessor :confirm_refund
end
