class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def jersey
    @products = Product.all.where(category: "Jersey")
  end

  def pantalones

  end

  def faldas

  end

  def camisas

  end

  def camisetas

  end

  def complementos

  end

  def botas

  end

  def outlet

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

end
