# frozen_string_literal: true

json.array! @response do |record|
  json.extract! record, :attribute_value_id, :value
end
