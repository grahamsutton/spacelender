class Period < ActiveRecord::Base
  belongs_to :listing
  nilify_blanks :only => [:start, :end]
end
