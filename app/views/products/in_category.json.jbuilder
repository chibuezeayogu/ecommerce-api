# frozen_string_literal: true

json.count @response.includes(:product).count
json.rows @response.includes(:product).limit(product_limit).offset(product_offset).each do |product|
  json.product_id product.product_id
  json.name product.product.name
  json.description product.product.description.truncate(description_length)
  json.price product.product.price
  json.discounted_price product.product.discounted_price
  json.thumbnail product.product.thumbnail
end
