# frozen_string_literal: true

class AttributeValue < ApplicationRecord
  self.table_name = 'attribute_value'

  belongs_to :feature, foreign_key: 'attribute_id', class_name: 'Attribute'
  has_many :product_attributes
  has_many :products, through: :product_attributes
end
