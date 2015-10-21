class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.belongs_to :invoice, index: true
      t.integer :refundee_id
      t.text :reason

      t.timestamps null: false
    end
    add_foreign_key :refunds, :invoices
  end
end
