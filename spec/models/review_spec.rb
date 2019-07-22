# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'Review Associations' do
    it { is_expected.to belong_to :product }
    it { is_expected.to belong_to :customer }
  end

  context 'Validation' do
    let!(:review) { create :review }

    it { is_expected.to validate_presence_of :review }
    it { is_expected.to validate_presence_of :rating }
  end
end
