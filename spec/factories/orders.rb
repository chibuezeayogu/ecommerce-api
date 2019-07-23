# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total_amount { 0.0 }
    created_on { DateTime.current }
    shipped_on { DateTime.current }
    status { 0 }
    comments { Faker::Lorem.sentence }
    customer
    shipping
    tax
  end
end
