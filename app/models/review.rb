# frozen_string_literal: true

class Review < ApplicationRecord
  self.table_name = 'review'

  belongs_to :product
  belongs_to :customer

  validates :review, :rating, presence: true
  before_create :set_created_on

  def set_created_on
    self.created_on = DateTime.current
  end
end
