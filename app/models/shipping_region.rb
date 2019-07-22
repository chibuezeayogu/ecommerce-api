# frozen_string_literal: true

class ShippingRegion < ApplicationRecord
  self.table_name = 'shipping_region'

  has_many :customer, inverse_of: :shipping_region
  has_many :shippings
end
