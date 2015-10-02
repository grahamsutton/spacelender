class AddImageableColumnsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :imageable_type, :string
    add_column :pictures, :imageable_id, :integer
  end
end
