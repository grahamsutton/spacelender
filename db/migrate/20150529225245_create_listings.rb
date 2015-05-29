class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :listings, :users
  end
end
