# frozen_string_literal: true

class Category < ApplicationRecord
  self.table_name = 'category'

  belongs_to :department
end
