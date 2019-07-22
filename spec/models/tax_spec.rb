# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tax, type: :model do
  context 'Tax Assocations' do
    it { is_expected.to have_many(:orders).inverse_of(:tax) }
  end
end
