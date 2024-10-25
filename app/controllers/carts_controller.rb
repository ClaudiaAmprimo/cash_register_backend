class CartsController < ApplicationController
  before_action :set_cart

  def show
    render json: {
      items: format_cart_items(@cart.cart_items),
      total_price: @cart.total_price.to_f
    }
  end

  def add_product
    product = Product.find_by(code: params[:product_code])

    if product
      @cart.add_product(product)
      session[:cart_id] = @cart.id
      render json: {
        items: format_cart_items(@cart.cart_items),
        total_price: @cart.total_price.to_f
      }
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def remove_product
    product = Product.find_by(code: params[:product_code])

    if product
      @cart.remove_product(product)
      render json: {
        items: format_cart_items(@cart.cart_items),
        total_price: @cart.total_price.to_f
      }
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  private

  def set_cart
    Rails.logger.info "Session Cart ID: #{session[:cart_id]}"
    @cart = Cart.find_by(id: session[:cart_id])

    unless @cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def format_cart_items(items)
    items.map do |item|
      {
        product_code: item.product.code,
        quantity: item.quantity,
        total_price: item.total_price.to_f
      }
    end
  end
end
