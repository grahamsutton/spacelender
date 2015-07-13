class RemoveStartEndColumnsFromPeriods < ActiveRecord::Migration
  def change
    remove_column :periods, :start, :date
    remove_column :periods, :end, :date
    remove_column :periods, :start_time, :time
    remove_column :periods, :end_time, :time
  end
end
