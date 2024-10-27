require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @product_gr1 = Product.create(code: 'GR1', name: 'Green Tea', price: 3.11)
    @product_sr1 = Product.create(code: 'SR1', name: 'Strawberries', price: 5.00)
    @product_cf1 = Product.create(code: 'CF1', name: 'Coffee', price: 11.23)
    @cart = Cart.create
  end

  test "should calculate total price for basket with two Green Tea (GR1,GR1)" do
    @cart.add_product(@product_gr1)
    @cart.add_product(@product_gr1)
    assert_in_delta 3.11, @cart.total_price, 0.01
  end

  test "should calculate total price for basket with SR1, SR1, GR1, SR1" do
    @cart.add_product(@product_sr1)
    @cart.add_product(@product_sr1)
    @cart.add_product(@product_gr1)
    @cart.add_product(@product_sr1)
    assert_in_delta 16.61, @cart.total_price, 0.01
  end

  test "should calculate total price for basket with GR1, CF1, SR1, CF1, CF1" do
    @cart.add_product(@product_gr1)
    @cart.add_product(@product_cf1)
    @cart.add_product(@product_sr1)
    @cart.add_product(@product_cf1)
    @cart.add_product(@product_cf1)
    assert_in_delta 30.57, @cart.total_price, 0.01
  end
end
