# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShoppingCart Endpoint' do
  describe 'Get shoppingcart/generateUniqueId' do
    context 'when a user visits shoppingcart/generateUniqueId' do
      it 'should return a unique cart_id' do
        get '/shoppingcart/generateUniqueId'

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json).to include 'cart_id'
      end
    end
  end

  describe 'Get /shoppingcart/:cart_id with records in the db' do
    let(:shopping_cart) { create(:shopping_cart) }

    context 'when a user visits /shoppingcart/:cart_id endpoint' do
      it 'should return an array of product in cart' do
        get "/shoppingcart/#{shopping_cart.cart_id}"

        expect(response).to be_successful
        expect(json).to_not be_empty
      end
    end

    context 'when a user visits /shoppingcart/:cart_id with none existing cart_id' do
      let(:none_existing_cart_id) { 5 }

      it 'should return a 404 error hash' do
        get "/shoppingcart/#{none_existing_cart_id}"

        expect(response).to be_a_not_found
        expect(json).to_not be_empty
      end
    end
  end

  describe 'POST /shoppingcart/add' do
    let(:shopping_cart) { create(:shopping_cart) }

    context 'when a user visits /shoppingcart/add supplying the right fields' do
      it 'should return 400 error hash' do
        post '/shoppingcart/add'

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('SHC_02')
        expect(json['error']['message']).to match('The following field(s) are required')
        expect(json['error']['fields']).to match('product, cart_id, features')
      end
    end

    context 'when a user visits /shoppingcart/:cart_id with none existing cart_id' do
      let(:product) { create(:product) }
      let(:params) do
        {
          features: 'SM, L',
          cart_id: SecureRandom.hex(10),
          product_id: product.product_id
        }
      end

      it 'should an array of products in the cart' do
        post '/shoppingcart/add', params: params

        expect(response).to be_created
        expect(json).to_not be_empty
      end
    end
  end
end
