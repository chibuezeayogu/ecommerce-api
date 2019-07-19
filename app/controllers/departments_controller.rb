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
    params_validation(Department, :set_department, :department_id, 'DEP', params)
  end

  def department_params
    params.permit(:department_id)
  end
end
