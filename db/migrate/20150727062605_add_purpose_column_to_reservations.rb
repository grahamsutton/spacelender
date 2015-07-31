class AddPurposeColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :purpose, :text
  end
end
