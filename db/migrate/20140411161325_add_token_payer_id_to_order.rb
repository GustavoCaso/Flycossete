class AddTokenPayerIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string
    add_column :orders, :payer_id, :string
  end
end
