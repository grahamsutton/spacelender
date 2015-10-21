class AddRefundTokenColumnToRefunds < ActiveRecord::Migration
  def change
    add_column :refunds, :refund_token, :string
  end
end
