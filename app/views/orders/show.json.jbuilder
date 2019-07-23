# frozen_string_literal: true

subtotal = { subtotal: @response.unit_cost * @response.quantity }
json.extract! @response, :order_id, :product_id, :features, :product_name, :quantity, :unit_cost
json.merge! subtotal
