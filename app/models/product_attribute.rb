# frozen_string_literal: true

class ProductAttribute < ApplicationRecord
  self.table_name = 'product_attribute'
  self.primary_keys = :product_id, :attribute_value_id

  belongs_to :attribute_value
  belongs_to :product
end
