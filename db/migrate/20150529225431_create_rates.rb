class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.belongs_to :listing, index: true
      t.float :amount
      t.string :date_range

      t.timestamps null: false
    end
    add_foreign_key :rates, :listings
  end
end
