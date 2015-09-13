class RemovePaidDateFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :paid_date, :string
  end
end
