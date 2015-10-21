class AddChargeColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :charge, :string
  end
end
