# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  context 'OrderDetail Associations' do
    it { is_expected.to belong_to :product }
    it { is_expected.to belong_to :order }
  end
end
