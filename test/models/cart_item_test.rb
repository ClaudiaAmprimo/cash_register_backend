require "test_helper"

class CartItemTest < ActiveSupport::TestCase
  def setup
    @product_gr1 = Product.create(code: 'GR1', name: 'Green Tea', price: 3.11)
    @product_sr1 = Product.create(code: 'SR1', name: 'Strawberries', price: 5.00)
    @product_cf1 = Product.create(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  test "total_price for GR1 with even 2" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_gr1, quantity: 2)
    assert_in_delta 3.11, cart_item.total_price, 0.01
  end

  test "total_price for GR1 with odd quantity" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_gr1, quantity: 3)
    assert_in_delta 6.22, cart_item.total_price, 0.01
  end

  test "total_price for SR1 with quantity less than 3" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_sr1, quantity: 2)
    assert_in_delta 10.00, cart_item.total_price, 0.01
  end

  test "total_price for SR1 with quantity of 3 or more" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_sr1, quantity: 3)
    assert_in_delta 13.50, cart_item.total_price, 0.01
  end

  test "total_price for CF1 with quantity less than 3" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_cf1, quantity: 2)
    assert_in_delta 22.46, cart_item.total_price, 0.01
  end

  test "total_price for CF1 with quantity of 3 or more" do
    cart = Cart.create
    cart_item = cart.cart_items.create(product: @product_cf1, quantity: 3)
    assert_in_delta 22.46, cart_item.total_price, 0.01
  end
end
