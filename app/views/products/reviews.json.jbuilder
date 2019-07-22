# frozen_string_literal: true

json.array! @response.reviews do |review|
  json.review review.review
  json.rating review.rating
  json.created_on review.created_on
end
