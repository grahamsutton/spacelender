class AddCardColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :card, :string
  end
end
