# frozen_string_literal: true

class Product < ApplicationRecord
  self.table_name = 'product'

  has_many :product_categories
  has_many :reviews
  has_many :categories, through: :product_categories
  has_many :product_attributes
  has_many :attribute_values, through: :product_attributes
  has_many :shopping_carts, inverse_of: :product

  scope :search, lambda { |query_string|
                   where('name LIKE ?', "%#{query_string}%")
                     .or(Product.where('description LIKE ?', "%#{query_string}%"))
                 }
end
