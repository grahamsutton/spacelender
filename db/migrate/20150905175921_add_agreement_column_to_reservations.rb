class AddAgreementColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :agreement, :boolean
  end
end
