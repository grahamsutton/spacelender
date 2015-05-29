class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :listing, index: true
      t.float :amount
      t.datetime :rental_date
      t.text :remak
      t.datetime :paid_date
      t.integer :receiver_id
      t.float :discount_amount
      t.string :discount_type

      t.timestamps null: false
    end
    add_foreign_key :invoices, :listings
  end
end
