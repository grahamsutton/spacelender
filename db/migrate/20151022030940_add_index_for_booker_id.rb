class AddIndexForBookerId < ActiveRecord::Migration
  def change
    add_index :reservations, :booker_id
  end
end
