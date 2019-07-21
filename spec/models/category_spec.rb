# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Category Associations' do
    it { is_expected.to belong_to :department }
    it { is_expected.to have_many :product_categories }
    it { is_expected.to have_many(:products).through(:product_categories) }
  end
end
