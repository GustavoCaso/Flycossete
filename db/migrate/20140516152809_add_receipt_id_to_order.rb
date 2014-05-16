class AddReceiptIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :receipt_id, :integer
  end
end
