class AddReplyColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :reply, :string
  end
end
