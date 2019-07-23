# frozen_string_literal: true

user = { name: @current_user.name }
json.array! @current_user.orders.order(created_on: :desc) do |order|
  json.extract! order, :order_id, :total_amount, :created_on, :shipped_on, :status
  json.merge! user
end
