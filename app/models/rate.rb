class Rate < ActiveRecord::Base
  enum date_range: [:hourly, :daily, :weekly, :monthly]
  belongs_to :rateable, polymorphic: true

  validates :date_range, :no_duplicate_values => true

  def amount_with_date_range
  	# Had to break MVC convention a little
  	"#{ActionController::Base.helpers.number_to_currency(amount)} #{date_range}"
  end
end
