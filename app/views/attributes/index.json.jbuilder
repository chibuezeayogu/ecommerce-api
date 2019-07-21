# frozen_string_literal: true

if @attributes.empty?
  json.error @response
else
  json.array! @attributes
end
