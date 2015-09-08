class AddCardTokenFieldToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_token, :string
  end
end
