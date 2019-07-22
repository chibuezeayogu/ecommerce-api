# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'Customer Assocations' do
    it { is_expected.to belong_to :shipping_region }
    it { is_expected.to have_many :reviews }
    it { is_expected.to have_many :orders }
  end
end
