class AddSlugColumnToListings < ActiveRecord::Migration
  def change
    add_column :listings, :slug, :string
  end
end
