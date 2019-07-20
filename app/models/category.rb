# frozen_string_literal: true

class Category < ApplicationRecord
  self.table_name = 'category'

  belongs_to :department
  has_many :product_categories
  has_many :products, through: :product_categories
end
