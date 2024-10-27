require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(code: 'GR1', name: 'Green Tea', price: 3.11)
  end

  test "should be valid with valid attributes" do
    assert @product.valid?
  end

  test "should require a code" do
    @product.code = nil
    assert_not @product.valid?
    assert_includes @product.errors[:code], "can't be blank"
  end

  test "should require a unique code" do
    duplicate_product = @product.dup
    @product.save
    assert_not duplicate_product.valid?
    assert_includes duplicate_product.errors[:code], "has already been taken"
  end

  test "should require a name" do
    @product.name = nil
    assert_not @product.valid?
    assert_includes @product.errors[:name], "can't be blank"
  end

  test "should require a price" do
    @product.price = nil
    assert_not @product.valid?
    assert_includes @product.errors[:price], "can't be blank"
  end

  test "should require price to be a non-negative number" do
    @product.price = -1
    assert_not @product.valid?
    assert_includes @product.errors[:price], "must be greater than or equal to 0"
  end
end
