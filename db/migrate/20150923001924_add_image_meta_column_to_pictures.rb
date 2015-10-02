class AddImageMetaColumnToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :image_meta, :text
  end
end
