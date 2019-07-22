# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :tax
  belongs_to :shipping
end
