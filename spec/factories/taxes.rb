# frozen_string_literal: true

FactoryBot.define do
  factory :tax do
    tax_type { Faker::Lorem.sentence }
    tax_percentage { 0.00 }
  end
end
