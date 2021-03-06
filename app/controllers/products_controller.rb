class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_current
  before_action :set_action, except: [:show]

  def index
    @products = Product.all
  end

  def jersey
    @products = Product.all.where(category: "Jersey")
  end

  def pantalones
    @products = Product.all.where(category: "Pantalones")
  end

  def faldas
    @products = Product.all.where(category: "Vestidos/Faldas")
  end

  def camisas
    @products = Product.all.where(category: "Camisas")
  end

  def chaquetas
    @products = Product.all.where(category: "Chaquetas/Blazer")
  end

  def complementos
    @products = Product.all.where(category: "Complementos")
  end

  def botas
    @products = Product.all.where(category: "Botas")
  end

  def outlet
    @products = Product.all.where(category: "Outlet")
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      @sizes = @product.size.split(' ').map{|x| ["Talla: #{x}", x]}
    end

    def set_current
      @current = true
    end

    def set_action
      @action = action_name
    end


end
