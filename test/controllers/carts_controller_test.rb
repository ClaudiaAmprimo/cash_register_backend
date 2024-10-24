require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Product.create(code: 'GR1', name: 'Green Tea', price: 3.11)
    Product.create(code: 'SR1', name: 'Strawberries', price: 5.00)
    Product.create(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  test "should add product and calculate total price with discount for green tea" do
    post add_product_carts_url, params: { product_code: 'GR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'GR1' }
    assert_response :success

    get carts_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_in_delta 3.11, json['total_price'], 0.01
  end

  test "should apply discount for bulk strawberries purchase" do
    post add_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success

    get carts_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_in_delta 13.50, json['total_price'], 0.01
  end

  test "should apply discount for coffee when buying 3 or more" do
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success

    get carts_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_in_delta 22.46, json['total_price'], 0.01
  end

  test "should calculate correctly total price with various products" do
    post add_product_carts_url, params: { product_code: 'GR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success

    get carts_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_in_delta 30.57, json['total_price'], 0.01
  end

  test "should remove product updating total price" do
    post add_product_carts_url, params: { product_code: 'GR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success
    post add_product_carts_url, params: { product_code: 'CF1' }
    assert_response :success

    delete remove_product_carts_url, params: { product_code: 'SR1' }
    assert_response :success

    get carts_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_in_delta 14.34, json['total_price'], 0.01
  end
end
