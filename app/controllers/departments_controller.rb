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
    params_validation(:set_department, :department_id, 'DEP')

    return if @response&.any?

    @response = Department.find(params[:department_id])
  rescue ActiveRecord::RecordNotFound
    @response = response_message(
      'DEP_02',
      "Department with department_id=#{params[:department_id]} does not exist.",
      'department_id',
      404
    )
    json_response(:set_department, :not_found)
  end

  def department_params
    params.permit(:department_id)
  end
end
