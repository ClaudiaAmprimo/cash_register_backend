# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

products = [
  { code: 'GR1', name: 'Green Tea', price: 3.11 },
  { code: 'SR1', name: 'Strawberries', price: 5.00 },
  { code: 'CF1', name: 'Coffee', price: 11.23 }
]

products.each do |product_attrs|
  Product.find_or_create_by(code: product_attrs[:code]) do |product|
    product.name = product_attrs[:name]
    product.price = product_attrs[:price]
  end
end
