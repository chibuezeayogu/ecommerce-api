# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  context 'Shipping Assocations' do
    it { is_expected.to belong_to :shipping_region }
    it { is_expected.to have_many(:orders).inverse_of(:shipping) }
  end
end
