# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

10.times do
  Property.create(
    name: Faker::Name.name,
    property_type: %i[house department land comercial_ground].sample,
    street: Faker::Address.street_name,
    external_number: Faker::Address.building_number,
    internal_number: Faker::Alphanumeric.alphanumeric(number: 5),
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    country: Faker::Address.country_code,
    rooms: rand(0..5),
    bathrooms: rand(1..3),
    comments: Faker::Lorem.sentence
  )
end
