class RemoveColumnsFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :picture_file_name, :string
    remove_column :listings, :picture_content_type, :string
    remove_column :listings, :picture_file_size, :string
    remove_column :listings, :picture_updated_at, :string
  end
end
