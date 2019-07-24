# frozen_string_literal: true

json.array! @response do |cart|
  json.item_id cart.id
  json.name cart.product.name
  json.attributes cart.features
  json.product_id cart.product_id
  json.price cart.product.price
  json.quantity cart.quantity
  json.image cart.product.image
  json.subtotal cart.quantity * cart.product.price
end
