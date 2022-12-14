# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

(1..10).each do |id|
  user = User.create(name: "User #{id}")
  recipe = Recipe.create(name: "Recipe #{id}", description: "Lorem ipsum dolor saber", user:)
  food = Food.create(name: "Food #{id}", measurement_unit: "grams", price: rand(10), user:)
end
  Recipe.first.foods = Food.all