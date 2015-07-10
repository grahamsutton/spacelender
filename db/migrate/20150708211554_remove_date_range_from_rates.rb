class RemoveDateRangeFromRates < ActiveRecord::Migration
  def change
    remove_column :rates, :date_range, :string
  end
end
