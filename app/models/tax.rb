# frozen_string_literal: true

class Tax < ApplicationRecord
  self.table_name = 'tax'

  has_many :orders, inverse_of: :tax
end
