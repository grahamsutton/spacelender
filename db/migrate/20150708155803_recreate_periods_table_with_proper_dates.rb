class RecreatePeriodsTableWithProperDates < ActiveRecord::Migration
  def change
  	create_table :periods do |t|
  		t.references :periodic, polymorphic: true, index: true
  		t.date :start
  		t.date :end
  		t.time :start_time
  		t.time :end_time
  	end
  end
end
