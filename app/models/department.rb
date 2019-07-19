# frozen_string_literal: true

class Department < ApplicationRecord
  self.table_name = 'department'

  has_many :categories
end
