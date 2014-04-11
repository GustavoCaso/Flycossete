class AddPostcodeCityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :post_code, :string
    add_column :orders, :city, :string
  end
end
