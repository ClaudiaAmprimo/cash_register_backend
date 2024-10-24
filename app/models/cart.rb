class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)

    if current_item
      current_item.increment!(:quantity)
    else
      cart_items.create(product: product, quantity: 1)
    end
  end

  def remove_product(product)
    current_item = cart_items.find_by(product_id: product.id)

    if current_item
      if current_item.quantity > 1
        current_item.decrement!(:quantity)
      else
        current_item.destroy
      end
    end
  end

  def total_price
    cart_items.to_a.sum(&:total_price).round(2)
  end
end
