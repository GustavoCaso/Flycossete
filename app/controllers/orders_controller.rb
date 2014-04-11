class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only:[:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders/new
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "Tu carrito esta vacio"
      return
    end
    @order = Order.new
  end


  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)
    if @order.save
      @order.add_line_items_from_cart(@cart)
      @paypal = PaypalInterface.new(@order)
      @paypal.express_checkout
      if @paypal.express_checkout_response.success?
        @paypal_url = @paypal.api.express_checkout_url(@paypal.express_checkout_response)
        redirect_to @paypal_url
      else
        flash[:notice] = "Habido un problema con Paypal"
        render :new
      end

    else
      flash[:notice] = "Hubo un problema con el formulario"
      render :new
    end
  end

  def notify_success
    @order = Order.where(token: params[:token]).first
    @order.update_attribute(:payer_id, params[:PayerID])
    @paypal = PaypalInterface.new(@order)
    @paypal.do_express_checkout
    Cart.find(session[:cart_id]).destroy
    session[:cart_id] = nil
  end

  def notify_cancel
  end

  def notify

  end




  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :post_code, :city, :email_confirmation)
    end
end
