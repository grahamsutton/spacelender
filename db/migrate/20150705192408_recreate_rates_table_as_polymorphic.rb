class RecreateRatesTableAsPolymorphic < ActiveRecord::Migration
  def change
  	create_table :rates do |t|
	  	t.references :rateable, polymorphic: true, index: true
	  	t.float :amount
	  	t.string :date_range
	  	t.timestamps null: false
	end
  end
end
