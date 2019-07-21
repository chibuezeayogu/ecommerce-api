# frozen_string_literal: true

class DepartmentsController < ApplicationController
  before_action :set_department, only: :show

  def index
    @departments = Department.all
    if @departments.empty?
      @response = response_message('DEP_03', 'Departments list is empty.', 'Departments', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def show; end

  private

  def set_department
    params_validation(:department_id, 'DEP')
    return json_response(:set_department, :bad_request) if @response&.any?

    get_record_by_id(Department, :set_department, :department_id, 'DEP')
  end

  def department_params
    params.permit(:department_id)
  end
end
