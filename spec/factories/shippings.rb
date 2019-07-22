# frozen_string_literal: true

FactoryBot.define do
  factory :shipping do
    shipping_type { Faker::Lorem.sentence }
    shipping_cost { 5.99 }
    shipping_region
  end
end
