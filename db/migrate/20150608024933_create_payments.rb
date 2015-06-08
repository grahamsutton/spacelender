class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :reservation, index: true
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.integer :card_number
      t.integer :card_verification
      t.date :card_expires_on

      t.timestamps null: false
    end
    add_foreign_key :payments, :reservations
  end
end
