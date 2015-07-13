class AddStartEndColumnsToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :start, :datetime
    add_column :periods, :end, :datetime
  end
end
