require 'paypal-sdk-merchant'

class PaypalInterface

  attr_reader :api, :express_checkout_response
  if Rails.env.eql?("development")
    PayPal::SDK.configure(
        :mode      => "sandbox",  # Set "live" for production
        :app_id    => "APP-80W284485P519543T",
        :username  => "jb-us-seller_api1.paypal.com",
        :password  => "WX4WTU3S8MY44S7F",
        :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy")
  else
    PayPal::SDK.configure(
        :mode      => "live",
        :app_id    => ENV['APP_ID'],
        :username  => ENV['USERNAME'],
        :password  => ENV['PASSWORD'],
        :signature => ENV['SIGNATURE'] )
  end

  HOST = Rails.env.eql?("development") ? "http://localhost:3000" : "http://www.flycosette.es"

  PAYPAL_RETURN_URL = Rails.application.routes.url_helpers.notify_success_orders_url(host: HOST)
  PAYPAL_CANCEL_URL = Rails.application.routes.url_helpers.notify_cancel_orders_url(host: HOST)
  PAYPAL_NOTIFY_URL = Rails.application.routes.url_helpers.notify_orders_url(host: HOST)

  def initialize(order)
    @api = PayPal::SDK::Merchant::API.new
    @order = order
    @line_items = @order.line_items
  end

  def express_checkout
    @set_express_checkout = @api.build_set_express_checkout({
      SetExpressCheckoutRequestDetails: {
        ReturnURL: PAYPAL_RETURN_URL,
        CancelURL: PAYPAL_CANCEL_URL,
        PaymentDetails: [
          {
            NotifyURL: PAYPAL_NOTIFY_URL,
            OrderTotal: {
              currencyID: "EUR",
              value: @order.total + Order::SHIPPING_PRICE
            },
            ItemTotal: {
              currencyID: "EUR",
              value: @order.total
            },
            ShippingTotal: {
              :currencyID => "EUR",
              :value => Order::SHIPPING_PRICE
            },
            PaymentDetailsItem:
              @line_items.map do |item|
               {
                 Name: "#{item.product.name} talla:(#{item.size})",
                 Quantity: item.quantity,
                 Amount: {
                   currencyID: "EUR",
                   value: item.product.price
                 },
                 ItemCategory: "Physical"
               }
              end,
            PaymentAction: "Sale"
          }
        ]
      }
    })

    @express_checkout_response = @api.set_express_checkout(@set_express_checkout)

    if @express_checkout_response.success?
      @order.set_payment_token(@express_checkout_response.Token)
    else
      @express_checkout_response.Errors
      raise @express_checkout_response.Errors.inspect
    end
  end


  def do_express_checkout
    @do_express_checkout_payment = @api.build_do_express_checkout_payment(
      {
        DoExpressCheckoutPaymentRequestDetails:{
          PaymentAction: "Sale",
          Token: @order.token,
          PayerID: @order.payer_id,
          PaymentDetails: [{
            OrderTotal: {
              currencyID: "EUR",
              value: @order.total + Order::SHIPPING_PRICE
            },
            NotifyURL: PAYPAL_NOTIFY_URL
          }]
        }
      }
    )

    @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)


    if @do_express_checkout_payment_response.success?
      @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails
      @do_express_checkout_payment_response.FMFDetails
      @order.update_stock
    else
      @do_express_checkout_payment_response.Errors
      raise @do_express_checkout_payment_response.Errors.inspect
    end

  end
end

