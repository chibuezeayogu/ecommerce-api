if @response&.any?
  json.error @response
else
  json.name @review.customer.name
  json.review @review.review
  json.rating @review.rating
  json.created_on @review.created_on
end