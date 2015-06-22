class Period < ActiveRecord::Base
  belongs_to :listing
  nilify_blanks
end
