# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attributes Endpoint' do
  describe 'Get /attributes' do
    context 'when a user visits /attributes with no records in db ' do
      it 'should return 404 error hash' do
        get '/attributes'

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
        expect(json['error']['code']).to match('ART_03')
        expect(json['error']['message']).to match('Attributes field is empty.')
        expect(json['error']['fields']).to match('Attributes')
        expect(json['error']['status']).to match(404)
      end
    end

    context "when a user visits /attributes endpoint with records in db'" do
      let!(:attributes) { create_list(:attribute, 3) }

      it 'should return an array of attributes' do
        get '/attributes'

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end

  describe 'Get /attributes/:attribute_id with records in the db' do
    let!(:attribute) { create(:attribute) }

    context 'when a user visits /attributes/:attribute_id endpoint' do
      it 'should return a attribute hash' do
        get "/attributes/#{attribute.attribute_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'attribute_id'
        expect(json).to include 'name'
      end
    end

    context 'when a user visits /attributes/:attribute_id with none existing attribute_id' do
      let(:none_existing_attribute_id) { 5 }

      it 'should return a 404 error hash' do
        get "/attributes/#{none_existing_attribute_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /attributes/:attribute_id endpoint with an invalid record id' do
      let(:invalid_attribute_id) { 's' }

      it 'should return a 400 error hash' do
        get "/attributes/#{invalid_attribute_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('ART_01')
        expect(json['error']['message']).to match('attribute_id is not a number.')
        expect(json['error']['fields']).to match('attribute_id')
      end
    end
  end

  describe 'Get /attributes/inProduct/:product_id' do
    context 'when a user visits /attributes/inProduct/:product_id endpoint with no records' do
      let(:none_existing_product_id) { 5 }

      it 'should return a 404 error hash' do
        get "/attributes/inProduct/#{none_existing_product_id}"

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_02')
        expect(json['error']['message']).to match('Product with product_id=5 does not exist.')
        expect(json['error']['fields']).to match('product_id')
      end
    end

    context 'when a user visits /attributes/inProduct/:product_id endpoint with an invalid record id' do
      let(:invalid_product_id) { 's' }

      it 'should return a 400 error hashs' do
        get "/attributes/inProduct/#{invalid_product_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_01')
        expect(json['error']['message']).to match('product_id is not a number.')
        expect(json['error']['fields']).to match('product_id')
      end
    end

    context 'when a user visits /attributes/inProduct/:product_id endpoint with record(s)' do
      let!(:product_attribute) { create_list(:product_attribute, 3) }

      it 'should return an array of product hashes' do
        get "/attributes/inProduct/#{product_attribute.first.product_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end

  describe 'Get /attributes/values/:attribute_id' do
    context 'when a user visits /attributes/values/:attribute_id endpoint with no records' do
      let(:none_existing_attribute_id) { 5 }

      it 'should return a 404 error hash' do
        get "/attributes/values/#{none_existing_attribute_id}"

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('ART_02')
        expect(json['error']['message']).to match('AttributeValue with attribute_id=5 does not exist.')
        expect(json['error']['fields']).to match('attribute_id')
      end
    end

    context 'when a user visits /attributes/values/:attribute_id endpoint with an invalid record id' do
      let(:invalid_attribute_id) { 's' }

      it 'should return a 400 error hashs' do
        get "/attributes/values/#{invalid_attribute_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('ART_01')
        expect(json['error']['message']).to match('attribute_id is not a number.')
        expect(json['error']['fields']).to match('attribute_id')
      end
    end

    context 'when a user visits /attributes/values/:attribute_id endpoint with record(s)' do
      let!(:attribute_value) { create_list(:attribute_value, 3) }

      it 'should return an array of product hashes' do
        get "/attributes/values/#{attribute_value.first.attribute_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end
end
