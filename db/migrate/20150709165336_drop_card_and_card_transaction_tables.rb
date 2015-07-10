class DropCardAndCardTransactionTables < ActiveRecord::Migration
  def up
  	drop_table :card_transactions
  	drop_table :cards
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
