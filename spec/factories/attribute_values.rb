# frozen_string_literal: true

FactoryBot.define do
  factory :attribute_value do
    association :feature, factory: :attribute
    value { Faker::Lorem.word }
  end
end
