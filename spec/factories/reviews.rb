# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    review { Faker::Lorem.sentence }
    rating { 5 }
    customer
    product
  end
end
