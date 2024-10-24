class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    PricingRules.total_price(product, quantity).round(2)
  end
end
