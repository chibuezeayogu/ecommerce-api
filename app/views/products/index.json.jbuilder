# frozen_string_literal: true

if @products.empty?
  json.error @response
else
  json.count @products.count
  json.rows @products.limit(product_limit).offset(product_offset), :product_id, :name, :description, :price, :discounted_price, :thumbnail
end
