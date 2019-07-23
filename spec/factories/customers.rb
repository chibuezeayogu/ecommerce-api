# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    shipping_region

    trait :with_credit_card do
      credit_card { 555_555_555_555_444 }
    end

    trait :with_address do
      address_1 { Faker::Address.full_address }
      address_2 { Faker::Address.full_address }
      region { Faker::Lorem.word }
      postal_code { 224 }
      city { Faker::Nation.capital_city }
      day_phone { '2347033497338' }
      eve_phone { '2347033497338' }
      mob_phone { '2347033497338' }
    end
  end
end
