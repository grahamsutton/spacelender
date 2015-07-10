class Period < ActiveRecord::Base
  belongs_to :periodic, :polymorphic => true
  nilify_blanks
end
