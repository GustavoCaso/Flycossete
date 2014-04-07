class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  # after_destroy :check_number_line_items_in_cart


  def total
    quantity * product.price
  end

  # private
  # def check_number_line_items_in_cart
  #   if cart.line_items.count < 1
  #     cart.destroy
  #     session[:cart_id] = nil
  #   end
  # end
end
