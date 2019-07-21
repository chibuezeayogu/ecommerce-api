# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductAttribute, type: :model do
  context 'ProductAttribute Assocations' do
    it { is_expected.to belong_to :attribute_value }
    it { is_expected.to belong_to :product }
  end
end
