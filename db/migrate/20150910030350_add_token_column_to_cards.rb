class AddTokenColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :token, :string
  end
end
