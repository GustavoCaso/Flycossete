class OrderMailer < ActionMailer::Base
  default from: "flycosette@gmail.com"

  def new_order(order)
    @order = order
    mail(to: @order.email, bcc: "flycosette@gmail.com", subject: "Nuevo pedido" )
  end

  def no_stock(product, size)
    @product = product
    @size = size
    mail(to: "flycosette@gmail.com", subject: "Producto sin stock")
  end
end
