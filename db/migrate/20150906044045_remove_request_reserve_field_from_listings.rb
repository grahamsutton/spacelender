class RemoveRequestReserveFieldFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :request_reserve, :boolean
  end
end
