# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories Endpoints', type: :request do
  describe 'Get /categories' do
    context 'when a user visits /categories endpoint with no records in db' do
      it 'should return 404 error hash' do
        get '/categories'

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('CAT_03')
        expect(json['error']['message']).to match('Categories field is empty.')
        expect(json['error']['fields']).to match('Categories')
      end
    end

    context 'when a user visits /categories endpoint with records in db' do
      let!(:categories) { create_list(:category, 3) }

      it 'should return an array of categories hashes' do
        get '/categories'

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'count'
        expect(json).to include 'rows'
        expect(json['rows'].count).to eq categories.count
      end
    end
  end

  describe 'Get /categories/:category_id with records in the db' do
    let!(:category) { create(:category) }

    context 'when a user visits /categories/:category_id endpoint' do
      it 'should return a category hash' do
        get "/categories/#{category.category_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'category_id'
        expect(json).to include 'name'
        expect(json).to include 'description'
        expect(json).to include 'category_id'
      end
    end

    context 'when a user visits /categories with none existing category_id' do
      let(:none_existing_category_id) { 5 }

      it 'should return a 404 error hash' do
        get "/categories/#{none_existing_category_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /categories/:category_id endpoint with an invalid record id' do
      let(:invalid_category_id) { 's' }

      it 'should return a 400 error hash' do
        get "/categories/#{invalid_category_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('CAT_01')
        expect(json['error']['message']).to match('category_id is not a number.')
        expect(json['error']['fields']).to match('category_id')
      end
    end
  end

  describe 'Get /categories/inProduct/:product_id' do
    context 'when a user visits /categories/inProduct/:product_id endpoint with no records' do
      it 'should return a 404 error hash' do
        get '/categories/inProduct/1'

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_02')
        expect(json['error']['message']).to match('Product with product_id=1 does not exist.')
        expect(json['error']['fields']).to match('product_id')
      end
    end

    context 'when a user visits /categories/inProduct/:product_id endpoint with an invalid record id' do
      let(:invalid_product_id) { 's' }

      it 'should return a 400 error hash' do
        get "/categories/inProduct/#{invalid_product_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_01')
        expect(json['error']['message']).to match('product_id is not a number.')
        expect(json['error']['fields']).to match('product_id')
      end
    end

    context 'when a user visits /categories/inProduct/:product_id endpoint with record(s)' do
      let!(:product_category) { create_list(:product_category, 3) }

      it 'should return an array of categories hashes' do
        get "/categories/inProduct/#{product_category.first.product_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end
  end
end
