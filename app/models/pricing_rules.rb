class PricingRules
  def self.total_price(product, quantity)
    case product.code
    when 'GR1'
      (quantity / 2) * product.price + (quantity % 2) * product.price
    when 'SR1'
      quantity >= 3 ? (quantity * 4.50) : (quantity * product.price)
    when 'CF1'
      quantity >= 3 ? (quantity * (product.price * (2.0 / 3.0))) : (quantity * product.price)
    else
      (quantity * product.price)
    end
  end
end
