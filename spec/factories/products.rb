# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    price { 10.00 }
    discounted_price { 5.00 }
    image { 'image.gif' }
    image_2 { 'image_2.gif' }
    thumbnail { 'thumbnail.gif' }
    display { 2 }
  end
end
