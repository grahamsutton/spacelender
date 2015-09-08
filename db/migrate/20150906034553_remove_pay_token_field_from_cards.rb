class RemovePayTokenFieldFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :pay_token, :string
  end
end
