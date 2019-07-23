# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  self.table_name = 'order_detail'

  belongs_to :order
  belongs_to :product
end
