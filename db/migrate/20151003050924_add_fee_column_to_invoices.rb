class AddFeeColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :fee, :float
  end
end
