class AddTotalIncomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_income, :float, default: 0
  end
end
