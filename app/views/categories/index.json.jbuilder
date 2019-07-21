# frozen_string_literal: true

if @categories.empty?
  json.error @response
else
  json.count @categories.count
  json.rows @categories.order(order_column).limit(category_limit).offset(category_offset)
end
