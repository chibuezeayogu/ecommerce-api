# frozen_string_literal: true

class Customer < ApplicationRecord
  self.table_name = 'customer'

  belongs_to :shipping_region
  has_many :reviews
  has_many :orders

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end
