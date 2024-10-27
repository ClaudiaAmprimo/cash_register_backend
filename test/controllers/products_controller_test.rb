require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    CartItem.delete_all
    Cart.delete_all
    Product.delete_all
    Product.create(code: 'GR1', name: 'Green Tea', price: 3.11)
    Product.create(code: 'SR1', name: 'Strawberries', price: 5.00)
    Product.create(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  test "should get index and return all products" do
    get products_url
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 3, json.size
    assert_equal 'GR1', json[0]['code']
    assert_equal 'Green Tea', json[0]['name']
    assert_in_delta 3.11, json[0]['price'].to_f, 0.01
  end
end
