# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Taxes Endpoint' do
  describe 'Get /tax' do
    context 'when a user visits /tax with no records in db ' do
      it 'should return 404 error hash' do
        get '/tax'

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
        expect(json['error']['code']).to match('TAX_03')
        expect(json['error']['message']).to match('Taxes field is empty.')
        expect(json['error']['fields']).to match('Taxes')
        expect(json['error']['status']).to match(404)
      end
    end

    context "when a user visits /tax endpoint with records in db'" do
      let!(:tax) { create_list(:tax, 3) }

      it 'should return an array of taxes' do
        get '/tax'

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end

  describe 'Get /tax/:tax_id with records in the db' do
    let!(:tax) { create(:tax) }

    context 'when a user visits /tax/tax_id endpoint' do
      it 'should return a attribute hash' do
        get "/tax/#{tax.tax_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'tax_id'
        expect(json).to include 'tax_type'
        expect(json).to include 'tax_percentage'
      end
    end

    context 'when a user visits /tax/tax_id with none existing tax_id' do
      let(:none_existing_tax_id) { 5 }

      it 'should return a 404 error hash' do
        get "/attributes/#{none_existing_tax_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /tax/tax_id endpoint with an invalid record id' do
      let(:invalid_tax_id) { 's' }

      it 'should return a 400 error hash' do
        get "/tax/#{invalid_tax_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('TAX_01')
        expect(json['error']['message']).to match('tax_id is not a number.')
        expect(json['error']['fields']).to match('tax_id')
      end
    end
  end
end
