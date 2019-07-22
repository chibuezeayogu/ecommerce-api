# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingRegion, type: :model do
  context 'Shipping Region Assocations' do
    it { is_expected.to have_many :shippings }
    it { is_expected.to have_many(:customer).inverse_of(:shipping_region) }
  end
end
