# frozen_string_literal: true

class ShoppingCart < ApplicationRecord
  self.table_name = 'shopping_cart'

  belongs_to :product

  validates :cart_id, :features, :product, presence: true
  before_create :set_added_on, :set_quantity

  def set_added_on
    self.added_on = DateTime.current
  end

  def set_quantity
    self.quantity = 1 if quantity.blank?
  end
end
