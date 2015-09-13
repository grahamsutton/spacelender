class RemoveMultipleColumnsFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :rental_date, :string
    remove_column :invoices, :remak, :string
    remove_column :invoices, :discount_amount, :string
    remove_column :invoices, :discount_type, :string
  end
end
