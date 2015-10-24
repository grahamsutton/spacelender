class Period < ActiveRecord::Base
  belongs_to :periodic, :polymorphic => true
end
