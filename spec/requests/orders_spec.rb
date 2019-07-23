# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders Endpoints' do
  let!(:customer) { create(:customer) }
  let(:with_token) { valid_header }

  describe 'Get /orders/:order_id' do
    context 'when a user visits /orders/:order_id without Header -> USER-KEY' do
      let(:none_existing_order_id) { 5 }

      it 'should return 404 error hash' do
        get "/orders/#{none_existing_order_id}", headers: {}

        expect(json).to_not be_empty
        expect(json['error']['code']).to match('AUT_01')
        expect(json['error']['message']).to match('No token provided')
        expect(json['error']['field']).to match('Header -> USER-KEY')
        expect(json['error']['status']).to match(422)
      end
    end

    context 'when a user visits /orders/:order_id with no records in db' do
      let(:none_existing_order_id) { 5 }

      it 'should return 404 error hash' do
        get "/orders/#{none_existing_order_id}", headers: with_token

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
        expect(json['error']['code']).to match('ORD_02')
        expect(json['error']['message']).to match('OrderDetail with order_id=5 does not exist.')
        expect(json['error']['fields']).to match('order_id')
        expect(json['error']['status']).to match(404)
      end
    end

    context 'when a user visits /orders/:order_id endpoint with an invalid record id' do
      let(:invalid_order_id) { 's' }

      it 'should return a 400 error hash' do
        get "/orders/#{invalid_order_id}", headers: with_token

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('ORD_01')
        expect(json['error']['message']).to match('order_id is not a number.')
        expect(json['error']['fields']).to match('order_id')
      end
    end
  end
end
