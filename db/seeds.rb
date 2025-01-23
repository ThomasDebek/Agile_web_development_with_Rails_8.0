# db/seeds.rb

require 'faker'

# Usuń istniejące dane, jeśli chcesz zacząć od zera
Product.destroy_all

# Generuj 20 przykładowych produktów
20.times do
  Product.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 15),
    price: Faker::Commerce.price(range: 10.0..1000.0, as_string: false)
  )
end

puts "Seed data for products has been successfully created!"