# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    address_1 { Faker::Address.full_address }
    address_2 { Faker::Address.full_address }
    credit_card { Faker::Business.credit_card_number }
    region { Faker::Lorem.word }
    postal_code { Faker::Address.postcode }
    city { Faker::Nation.capital_city }
    shipping_region
    day_phone { Faker::PhoneNumber.cell_phone }
    eve_phone { Faker::PhoneNumber.cell_phone }
    mob_phone { Faker::PhoneNumber.cell_phone }
  end
end
