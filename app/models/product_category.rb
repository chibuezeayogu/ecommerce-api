# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  self.table_name = 'product_category'
  self.primary_keys = :product_id, :category_id

  belongs_to :category
  belongs_to :product
end
