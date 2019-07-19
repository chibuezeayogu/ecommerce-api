# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Category Associations' do
    it { is_expected.to belong_to :department }
  end
end
