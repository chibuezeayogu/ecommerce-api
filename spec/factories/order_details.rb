# frozen_string_literal: true

FactoryBot.define do
  factory :order_detail do
    features { Faker::Lorem.word }
    product_name { Faker::Lorem.word }
    quantity { 5 }
    unit_cost { 20.23 }
    order
    product
  end
end
