# frozen_string_literal: true

if @response&.any?
  json.error @response
else
  json.item_id @shopping_cart.id
  json.name @shopping_cart.product.name
  json.attributes @shopping_cart.features
  json.product_id @shopping_cart.product_id
  json.price @shopping_cart.product.price
  json.quantity @shopping_cart.quantity
  json.image @shopping_cart.product.image
  json.subtotal @shopping_cart.quantity * @shopping_cart.product.price
end
