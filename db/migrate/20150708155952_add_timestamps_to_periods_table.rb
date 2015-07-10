class AddTimestampsToPeriodsTable < ActiveRecord::Migration
  	def change_table
      add_column(:periods, :created_at, :datetime)
      add_column(:periods, :updated_at, :datetime)
    end
end
