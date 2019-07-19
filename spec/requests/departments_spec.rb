# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department API', type: :request do
  describe 'GET /departments' do
    context 'when a user visits /departments and there is not departments' do
      it 'should return 404 error message' do
        get '/departments'

        expect(response).to have_http_status(404)
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_03')
        expect(json['error']['message']).to match('Departments list is empty.')
        expect(json['error']['fields']).to match('Departments')
      end
    end

    context 'when a user visits /departments' do
      let!(:department) { create_list(:department, 3) }

      it 'should return an array of departments' do
        get '/departments'

        expect(response).to have_http_status(200)
        expect(json.count).to eq 3
      end
    end
  end

  describe 'GET /departments/:department_id' do
    context 'when a user visits /departments/:department_id' do
      it 'should return a department with that department id' do
        get "/departments/#{Department.first.department_id}"

        expect(response).to have_http_status(200)
        expect(json).to include 'department_id'
        expect(json).to include 'name'
        expect(json).to include 'description'
      end
    end

    context 'when a user visits /departments/:department_id with none existing record' do
      let(:none_eisting_department_id) { 5 }

      it 'should return a 404 error message' do
        get "/departments/#{none_eisting_department_id}"

        expect(response).to have_http_status(404)
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_02')
        expect(json['error']['message']).to match('Department with department_id=5 does not exist.')
        expect(json['error']['fields']).to match('department_id')
      end
    end

    context 'when a user visits /departments/:department_id with an invalid department_id' do
      let(:invalid_department_id) { 's' }

      it 'should return a 400 error message' do
        get "/departments/#{invalid_department_id}"

        expect(response).to have_http_status(400)
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_01')
        expect(json['error']['message']).to match('department_id is not a number.')
        expect(json['error']['fields']).to match('department_id')
      end
    end
  end
end
