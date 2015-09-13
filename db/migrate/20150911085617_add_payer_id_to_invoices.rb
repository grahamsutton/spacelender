class AddPayerIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payer_id, :integer
  end
end
