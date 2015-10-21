class AddUserDetailColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer
    add_column :users, :birthdate, :date
    add_column :users, :phone, :string
    add_column :users, :base_city, :string
  end
end
