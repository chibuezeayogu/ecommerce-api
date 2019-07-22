# frozen_string_literal: true

class Shipping < ApplicationRecord
  self.table_name = 'shipping'

  belongs_to :shipping_region
  has_many :orders, inverse_of: :shipping
end
