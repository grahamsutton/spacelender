class CreateCardsTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :user
      t.string :token
      t.string :card_token
      t.integer :last4
      t.timestamps
    end
  end
end
