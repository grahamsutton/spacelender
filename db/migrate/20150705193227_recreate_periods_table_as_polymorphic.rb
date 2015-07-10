class RecreatePeriodsTableAsPolymorphic < ActiveRecord::Migration
  def change
  	create_table :periods do |t|
  		t.datetime :start
  		t.datetime :end
  		t.references :periodic, polymorphic: true, index: true
  		t.timestamps null: false
  	end
  end
end
