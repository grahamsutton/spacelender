class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :user, index: true
      t.string :pay_token

      t.timestamps null: false
    end
    add_foreign_key :cards, :users
  end
end
