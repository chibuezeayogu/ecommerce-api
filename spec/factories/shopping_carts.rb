# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_cart do
    product
    cart_id { SecureRandom.hex(10) }
    features { Faker::Lorem.word }
    quantity { 6 }
    buy_now { false }
    added_on { DateTime.current }
  end
end
