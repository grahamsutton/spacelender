class RemoveStartEndColumnsFromReservation < ActiveRecord::Migration
  def change
    remove_column :reservations, :from_date, :date
    remove_column :reservations, :to_date, :date
    remove_column :reservations, :start_time, :time
    remove_column :reservations, :end_time, :time
  end
end
