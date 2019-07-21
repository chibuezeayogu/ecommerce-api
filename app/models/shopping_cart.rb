# frozen_string_literal: true

class ShoppingCart < ApplicationRecord
  self.table_name = 'shopping_cart'

  belongs_to :product
end
