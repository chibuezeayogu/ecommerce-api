# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_region do
    shipping_region { Faker::Lorem.word }
  end
end
