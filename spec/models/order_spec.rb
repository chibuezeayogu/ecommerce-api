# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Order Assocations' do
    it { is_expected.to belong_to :customer }
    it { is_expected.to belong_to :shipping }
    it { is_expected.to belong_to :tax }
  end
end
