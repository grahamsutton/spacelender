class AddTokenColumnToReports < ActiveRecord::Migration
  def change
    add_column :reports, :token, :string
  end
end
