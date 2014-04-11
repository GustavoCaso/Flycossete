class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy



  def amount_items
    line_items.count
  end

  def add_product product, size
    current_item = line_items.where(product_id: product.id).first

    if current_item && current_item.size == size
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product)
      current_item.size = size
    end
    current_item
  end

  def total
    line_items.to_a.sum(&:total)
  end

end
