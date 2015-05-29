class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :listing, index: true
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
    add_foreign_key :locations, :listings
  end
end
