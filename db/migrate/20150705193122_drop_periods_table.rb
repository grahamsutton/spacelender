class DropPeriodsTable < ActiveRecord::Migration
  def up
  	drop_table :periods
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
