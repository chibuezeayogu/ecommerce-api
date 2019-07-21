# frozen_string_literal: true

FactoryBot.define do
  factory :product_attribute do
    product
    attribute_value
  end
end
