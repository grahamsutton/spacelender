class Rate < ActiveRecord::Base
  enum date_range: [:hourly, :daily, :weekly, :monthly]
  belongs_to :rateable, polymorphic: true

  validates :date_range, :no_duplicate_values => true
end
