# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers Endpoints' do
  let(:valid_params) do
    {
      name: 'Chibueze',
      email: 'chibuezeayogu@hotmail.com',
      password: '12345678',
      shipping_region_id: shipping_region.shipping_region_id
    }
  end
  let!(:shipping_region) { create(:shipping_region) }

  describe 'Post /customers' do
    context 'when the required fields are not supplied' do
      it 'should return 400 error hash' do
        post '/customers', params: { shipping_region_id: shipping_region.shipping_region_id }
        expect(json).to include 'error'
        expect(json['error']['code']).to match('USR_02')
        expect(json['error']['status']).to match(400)
        expect(json['error']['message']).to match('The following field(s) are required')
        expect(json['error']['fields']).to match('password, name, email')
      end
    end

    context 'when the required fields are not supplied' do
      it 'should a created customer hash' do
        post '/customers', params: valid_params

        expect(json).to include 'customer'
        expect(json).to include 'accessToken'
        expect(json).to include 'expiresIn'
        expect(json['customer']).to include 'schema'
      end
    end

    context 'when an existing email is supplied' do
      before do
        create(:customer, valid_params)
      end

      it 'should return 400 error hash' do
        post '/customers', params: valid_params

        expect(json).to include 'error'
        expect(json['error']['code']).to match('USR_04')
        expect(json['error']['status']).to match(400)
        expect(json['error']['message']).to match('Email already exists')
        expect(json['error']['field']).to match('Email')
      end
    end
  end

  describe 'POST /customers/login' do
    context 'when a registered user supplies the right information' do
      let!(:customer) { create(:customer, valid_params) }

      it 'should login the user' do
        post '/customers/login', params: { email: customer.email, password: customer.password }

        expect(json).to include 'customer'
        expect(json).to include 'accessToken'
        expect(json).to include 'expiresIn'
        expect(json['customer']).to include 'schema'
      end
    end

    context 'when a registered user is not registered' do
      let!(:customer) { create(:customer, valid_params) }

      it 'should a 400 error hash' do
        post '/customers/login', params: { email: 'wrong@mail.com', password: '1234567' }

        expect(json).to include 'error'
        expect(json['error']['code']).to match('USR_05')
        expect(json['error']['status']).to match(400)
        expect(json['error']['message']).to match('User is not registered')
        expect(json['error']['field']).to match('Email')
      end
    end

    context 'when a registered user supplies the wrong password' do
      let!(:customer) { create(:customer, valid_params) }

      it 'should a  400 error hash' do
        post '/customers/login', params: { email: customer.email, password: 'wrongpoassword' }

        expect(json).to include 'error'
        expect(json['error']['code']).to match('USR_01')
        expect(json['error']['status']).to match(400)
        expect(json['error']['message']).to match('Email or Password is invalid')
        expect(json['error']['field']).to match('Email/Password')
      end
    end
  end
end
