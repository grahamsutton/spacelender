class CreateFavoritedListings < ActiveRecord::Migration
  def change
    create_table :favorited_listings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :listing, index: true

      t.timestamps null: false
    end
    add_foreign_key :favorited_listings, :users
    add_foreign_key :favorited_listings, :listings
  end
end
