# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttributeValue, type: :model do
  context 'AttributeValue Associations' do
    it { is_expected.to belong_to :feature }
    it { is_expected.to have_many :product_attributes }
    it { is_expected.to have_many(:products).through(:product_attributes) }
  end
end
