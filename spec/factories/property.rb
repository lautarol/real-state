#  name            :string(128)      not null
#  type            :integer          not null
#  street          :string(128)      not null
#  external_number :string(12)       not null
#  internal_number :string(12)
#  neighborhood    :string(128)      not null
#  city            :string(64)       not null
#  country         :string(2)        not null
#  rooms           :integer          not null
#  bathrooms       :float            not null
#  comments        :string
FactoryBot.define do
  factory :property do
    name { Faker::Name.name }
    property_type { 'department' }
    street { Faker::Address.street_name }
    external_number { Faker::Address.building_number }
    internal_number { Faker::Alphanumeric.alphanumeric(number: 5) }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    country { Faker::Address.country_code }
    rooms { rand(0..5) }
    bathrooms { rand(1..3) }
    comments { Faker::Lorem.sentence }
  end
end
