class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :size
      t.integer :stock, default: 0
      t.string :category

      t.timestamps
    end
  end
end
