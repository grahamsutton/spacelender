class RemoveListingIdColumnFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :listing_id, :string
  end
end
