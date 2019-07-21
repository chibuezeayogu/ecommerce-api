# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Department Endpoints', type: :request do
  describe 'GET /departments' do
    context 'when a user visits /departments with no records in the db' do
      it 'should return 404 error hash' do
        get '/departments'

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_03')
        expect(json['error']['message']).to match('Departments list is empty.')
        expect(json['error']['fields']).to match('Departments')
      end
    end

    context 'when a user visits /departments with records in the db' do
      let!(:departments) { create_list(:department, 3) }

      it 'should return an array of departments hashes' do
        get '/departments'

        expect(response).to be_successful
        expect(json).to_not be_empty
        expect(json.count).to eq departments.count
      end
    end
  end

  describe 'GET /departments/:department_id' do
    context 'when a user visits /departments/:department_id with an none existing record id' do
      let(:none_existing_department_id) { 5 }

      it 'should return a 404 error hash' do
        get "/departments/#{none_existing_department_id}"

        expect(response).to be_a_not_found
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_02')
        expect(json['error']['message']).to match('Department with department_id=5 does not exist.')
        expect(json['error']['fields']).to match('department_id')
      end
    end

    context 'when a user visits /departments/:department_id with an invalid department_id' do
      let(:invalid_department_id) { 's' }

      it 'should return a 400 error hash' do
        get "/departments/#{invalid_department_id}"

        expect(response).to be_a_bad_request
        expect(json).to include 'error'
        expect(json['error']['code']).to match('DEP_01')
        expect(json['error']['message']).to match('department_id is not a number.')
        expect(json['error']['fields']).to match('department_id')
      end
    end

    context 'when a user visits /departments/:department_id' do
      let!(:department) { create(:department) }

      it 'should return a department with that department id' do
        get "/departments/#{department.department_id}"

        expect(response).to be_successful
        expect(json).to include 'department_id'
        expect(json).to include 'name'
        expect(json).to include 'description'
      end
    end
  end
end
