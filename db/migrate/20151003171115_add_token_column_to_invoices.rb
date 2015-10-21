class AddTokenColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :token, :string
  end
end
