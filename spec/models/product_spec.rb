# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Product Assocations' do
    it { is_expected.to have_many :product_categories }
    it { is_expected.to have_many :reviews }
    it { is_expected.to have_many :product_attributes }
    it { is_expected.to have_many(:categories).through(:product_categories) }
    it { is_expected.to have_many(:attribute_values).through(:product_attributes) }
    it { is_expected.to have_many(:shopping_carts).inverse_of(:product) }
  end
end
