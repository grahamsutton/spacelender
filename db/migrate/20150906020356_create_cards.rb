class CreateCards < ActiveRecord::Migration
  def up
    create_table :cards do |t|
      t.belongs_to :user, index: true
      t.string :pay_token

      t.timestamps null: false
    end
    add_foreign_key :cards, :users
  end

  def down
    drop_table :cards
  end
end
