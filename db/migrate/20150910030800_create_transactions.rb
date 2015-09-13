class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :reservation, index: true
      t.float :amound_paid
      t.datetime :paid_date
      t.integer :receiver_id

      t.timestamps null: false
    end
    add_foreign_key :transactions, :reservations
  end
end
