class AddActiveColumnToListings < ActiveRecord::Migration
  def change
    add_column :listings, :active, :boolean, :default => true
  end
end
