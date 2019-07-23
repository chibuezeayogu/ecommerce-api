# frozen_string_literal: true

user = { name: @response.customer.name }
json.extract! @response, :order_id, :total_amount, :created_on, :shipped_on, :status
json.merge! user
