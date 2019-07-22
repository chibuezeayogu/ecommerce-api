# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products Endpoints', type: :request do
  describe 'Get /products' do
    context 'when a user visits /products endpoint with no records in db' do
      it 'should return 404 error hash' do
        get '/products'

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_03')
        expect(json['error']['message']).to match('Products field is empty.')
        expect(json['error']['fields']).to match('Products')
      end
    end

    context 'when a user visits /products endpoint with records in db' do
      let!(:products) { create_list(:product, 3) }

      it 'should return an array of products hashes' do
        get '/products'

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'count'
        expect(json).to include 'rows'
        expect(json['rows'].count).to eq products.count
      end
    end
  end

  describe 'Get /products/:product_id with records in the db' do
    let!(:product) { create(:product) }

    context 'when a user visits /products/:product_id endpoint' do
      it 'should return a product hash' do
        get "/products/#{product.product_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'product_id'
        expect(json).to include 'name'
        expect(json).to include 'description'
        expect(json).to include 'price'
        expect(json).to include 'discounted_price'
      end
    end

    context 'when a user visits /products/:product_id  with none existing product_id' do
      let(:none_existing_product_id) { 5 }

      it 'should return a product hash' do
        get "/products/#{none_existing_product_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /products/:product_id endpoint with an invalid record id' do
      let(:invalid_category_id) { 's' }

      it 'should return a 400 error hash' do
        get "/products/#{invalid_category_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_01')
        expect(json['error']['message']).to match('product_id is not a number.')
        expect(json['error']['fields']).to match('product_id')
      end
    end
  end

  describe 'Get /products/:product_id/details with records in the db' do
    let!(:product) { create(:product) }

    context 'when a user visits /products/:product_id endpoint' do
      it 'should return a product hash' do
        get "/products/#{product.product_id}/details"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'product_id'
        expect(json).to include 'name'
        expect(json).to include 'description'
        expect(json).to include 'price'
        expect(json).to include 'discounted_price'
      end
    end

    context 'when a user visits /products/:product_id/details  with none existing product_id' do
      let(:none_existing_product_id) { 5 }

      it 'should return a product hash' do
        get "/products/#{none_existing_product_id}/details"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /products/:product_id/details endpoint with an invalid record id' do
      let(:invalid_product_id) { 's' }

      it 'should return a 400 error hash' do
        get "/products/#{invalid_product_id}/details"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_01')
        expect(json['error']['message']).to match('product_id is not a number.')
        expect(json['error']['fields']).to match('product_id')
      end
    end
  end

  describe 'Get /products/:product_id/locations with records in the db' do
    let!(:product_category) { create(:product_category) }

    context 'when a user visits /products/:product_id/locations endpoint' do
      it 'should return a product hash' do
        get "/products/#{product_category.product_id}/locations"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'category_id'
        expect(json).to include 'category_name'
        expect(json).to include 'department_id'
        expect(json).to include 'department_name'
      end
    end

    context 'when a user visits /products/:product_id/locations  with none existing product_id' do
      let(:none_existing_product_id) { 5 }

      it 'should return a product hash' do
        get "/products/#{none_existing_product_id}/locations"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /products/:product_id/locations endpoint with an invalid record id' do
      let(:invalid_category_id) { 's' }

      it 'should return a 400 error hash' do
        get "/products/#{invalid_category_id}/locations"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('PRO_01')
        expect(json['error']['message']).to match('product_id is not a number.')
        expect(json['error']['fields']).to match('product_id')
      end
    end
  end

  describe 'Get /products/inCategory/:category_id' do
    context 'when a user visits /products/inCategory/:category_id endpoint with no records' do
      let(:none_existing_category_id) { 5 }

      it 'should return a 404 error hash' do
        get "/products/inCategory/#{none_existing_category_id}"

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('CAT_02')
        expect(json['error']['message']).to match('ProductCategory with category_id=5 does not exist.')
        expect(json['error']['fields']).to match('category_id')
      end
    end

    context 'when a user visits /products/inCategory/:category_id endpoint with an invalid record id' do
      let(:invalid_product_id) { 's' }

      it 'should return a 400 error hash' do
        get "/products/inCategory/#{invalid_product_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('CAT_01')
        expect(json['error']['message']).to match('category_id is not a number.')
        expect(json['error']['fields']).to match('category_id')
      end
    end

    context 'when a user visits /products/inCategory/:category_id endpoint with record(s)' do
      let!(:product_category) { create_list(:product_category, 3) }

      it 'should return an array of categories hashes' do
        get "/products/inCategory/#{product_category.first.category_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'count'
        expect(json).to include 'rows'
        expect(json['rows']).to_not be_empty
      end
    end
  end

  describe 'Get /products/inDepartment/:department_id' do
    context 'when a user visits /products/inDepartment/:department_id endpoint with no records' do
      let(:none_existing_department_id) { 5 }

      it 'should return a 404 error hash' do
        get "/products/inDepartment/#{none_existing_department_id}"

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_02')
        expect(json['error']['message']).to match('Category with department_id=5 does not exist.')
        expect(json['error']['fields']).to match('department_id')
      end
    end

    context 'when a user visits /products/inDepartment/:department_id endpoint with an invalid record id' do
      let(:invalid_department_id) { 's' }

      it 'should return a 400 error hash' do
        get "/products/inDepartment/#{invalid_department_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_01')
        expect(json['error']['message']).to match('department_id is not a number.')
        expect(json['error']['fields']).to match('department_id')
      end
    end

    context 'when a user visits /products/inDepartment/:department_id endpoint with record(s)' do
      let!(:product_category) { create_list(:product_category, 3) }

      it 'should return an array of product hashes' do
        get "/products/inDepartment/#{Category.first.department_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'count'
        expect(json).to include 'rows'
        expect(json['rows']).to_not be_empty
      end
    end
  end
end
