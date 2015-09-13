class AddLast4ColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :card_last4, :integer
  end
end
