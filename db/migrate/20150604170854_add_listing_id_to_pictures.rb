class AddListingIdToPictures < ActiveRecord::Migration
  def change
    add_reference :pictures, :listing, index: true
    add_foreign_key :pictures, :listings
  end
end
