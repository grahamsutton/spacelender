class RemoveListingIdFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :listing_id, :string
  end
end
