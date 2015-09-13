class AddReservationIdColumnToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :reservation, index: true
    add_foreign_key :invoices, :reservations
  end
end
