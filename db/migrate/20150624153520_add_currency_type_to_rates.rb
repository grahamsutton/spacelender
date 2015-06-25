class AddCurrencyTypeToRates < ActiveRecord::Migration
  def change
    add_column :rates, :currency_type, :string
  end
end
