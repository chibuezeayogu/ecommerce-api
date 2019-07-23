# frozen_string_literal: true

if @response.shippings.empty?
  json.error do
    json.set! :code, 'SHR_O3'
    json.set! :message, "Shipping region with ID=#{@response.shipping_region_id} does not have shipping record."
    json.set! :field, 'Shipping Region'
    json.set! :status, 404
  end
else
  json.array! @response.shippings, :shipping_id, :shipping_type, :shipping_cost, :shipping_region_id
end
