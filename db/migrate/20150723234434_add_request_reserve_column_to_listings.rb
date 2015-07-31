class AddRequestReserveColumnToListings < ActiveRecord::Migration
  def change
    add_column :listings, :request_reserve, :boolean
  end
end
