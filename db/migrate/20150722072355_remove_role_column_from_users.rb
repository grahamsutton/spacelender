class RemoveRoleColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role, :integer
  end
end
