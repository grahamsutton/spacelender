class AddDateRangeToRates < ActiveRecord::Migration
  def change
    add_column :rates, :date_range, :integer
  end
end
