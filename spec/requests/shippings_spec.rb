# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shipping Regions Endpoint' do
  describe 'Get /shipping/regions' do
    context 'when a user visits /shipping/regions with no records in db' do
      it 'should return 404 error hash' do
        get '/shipping/regions'

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
        expect(json['error']['code']).to match('SHR_03')
        expect(json['error']['message']).to match('Shipping Regions field is empty.')
        expect(json['error']['fields']).to match('Shipping Regions')
        expect(json['error']['status']).to match(404)
      end
    end

    context "when a user visits /shipping/regions endpoint with records in db'" do
      let!(:shipping_region) { create_list(:shipping_region, 3) }

      it 'should return an array of shipping regions' do
        get '/shipping/regions'

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end

  describe 'Get /shipping/regions/shipping_region_id with records in the db' do
    let!(:shipping) { create(:shipping) }

    context 'when a user visits /shipping/regions/shipping_region_id endpoint' do
      it 'should return a shipping region hash' do
        get "/shipping/regions/#{shipping.shipping_region_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /shipping/regions/shipping_region_id with none existing id' do
      let(:none_existing_shipping_region_id) { 5 }

      it 'should return a 404 error hash' do
        get "/shipping/regions/#{none_existing_shipping_region_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /shipping/regions/shipping_region_id endpoint with an invalid record id' do
      let(:invalid_shipping_region_id) { 's' }

      it 'should return a 400 error hash' do
        get "/shipping/regions/#{invalid_shipping_region_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('SHR_01')
        expect(json['error']['message']).to match('shipping_region_id is not a number.')
        expect(json['error']['fields']).to match('shipping_region_id')
      end
    end
  end
end
