# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  before_action :set_department, only: :in_department
  before_action :set_product, only: :in_product
  helper_method :order_column, :category_offset, :category_limit

  def index
    @categories = Category.all
    unless @categories.any?
      @response = response_message('CAT_03', 'Categories field is empty.', 'Categories', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def show; end

  def in_product; end

  def in_department; end

  private

  def set_category
    params_validation(:category_id, 'CAT')
    return json_response(:set_category, :bad_request) if @response&.any?

    get_record_by_id(Category, :set_category, :category_id, 'CAT')
  end

  def set_department
    params_validation(:department_id, 'DEP')
    return json_response(:set_department, :bad_request) if @response&.any?

    @response = Department.find(params[:department_id]).categories
  rescue ActiveRecord::RecordNotFound
    @response = response_message(
      'DEP_02',
      "Department with department_id=#{params[:department_id]} does not exist.",
      'department_id',
      404
    )
    json_response(:set_department, :not_found)
  end

  def set_product
    params_validation(:product_id, 'PRO')
    return json_response(:set_product, :bad_request) if @response&.any?

    @response = Product.find(params[:product_id]).categories
  rescue ActiveRecord::RecordNotFound
    @response = response_message(
      'PRO_02',
      "Product with product_id=#{params[:product_id]} does not exist.",
      'product_id',
      404
    )
    json_response(:set_product, :not_found)
  end

  def category_params
    params.permit(
      :category_id,
      :product_id,
      :department_id,
      :page,
      :limit,
      :order [:category_id, :name]
    )
  end

  def order_column
    params[:order] ||= 'category_id'
  end

  def category_offset
    params[:page] ||= 1
    params[:page].to_i * category_limit.to_i - 20
  end

  def category_limit
    params[:limit] ||= 20
  end
end
