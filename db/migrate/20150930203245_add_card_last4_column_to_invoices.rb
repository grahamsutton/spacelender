class AddCardLast4ColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :card_last4, :string
  end
end
