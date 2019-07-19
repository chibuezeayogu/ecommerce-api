# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  context 'Department Associations' do
    it { is_expected.to have_many :categories }
  end
end
