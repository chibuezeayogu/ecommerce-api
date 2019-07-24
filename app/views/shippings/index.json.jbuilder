# frozen_string_literal: true

if @response&.any?
  json.error @response
else
  json.array! @shipping_regions, :shipping_region_id, :shipping_region
end
