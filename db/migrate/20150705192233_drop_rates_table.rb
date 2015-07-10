class DropRatesTable < ActiveRecord::Migration
  def up
  	drop_table :rates
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
