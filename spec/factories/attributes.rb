# frozen_string_literal: true

FactoryBot.define do
  factory :attribute do
    name { Faker::Lorem.word }
  end
end
