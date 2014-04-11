class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  validates_presence_of :name, :email, :email_confirmation, :address ,:post_code, :city
  validates_confirmation_of :email
  validates_format_of :email, with: /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i, :multiline => true

  SHIPPING_PRICE = 7

  def total
    line_items.to_a.sum(&:total)
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      line_items << item
    end
  end

  def update_stock
    line_items.each do |line_item|
      l = line_item.product
      l.stock -= line_item.quantity
      l.save!
    end
  end

  def set_payment_token token
    update_attribute(:token,token)
  end
end
