class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :listing, index: true
      t.integer :booker_id
      t.datetime :from_date
      t.datetime :to_date

      t.timestamps null: false
    end
    add_foreign_key :reservations, :listings
  end
end
