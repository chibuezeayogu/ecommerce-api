# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show details location reviews]
  before_action :set_category, only: :in_category
  before_action :set_department, only: :in_department
  helper_method :product_offset, :product_limit, :description_length, :all_words
  before_action :authenticate_request, only: :post_review

  def index
    @products = Product.all
    unless @products.any?
      @response = response_message('PRO_03', 'Products field is empty.', 'Products', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def in_category; end

  def in_department; end

  def show; end

  def details; end

  def location
    @response.categories.includes(:department).each do |category|
      @location = {
        category_id: category.category_id,
        category_name: category.name,
        department_id: category.department_id,
        department_name: category.department.name
      }
    end
    @location
  end

  def post_review
    @review = Review.new review_params
    @review.customer_id = @current_user.customer_id
    
    if @review.save
      json_response(:post_review, :create)
    else
      fields = @review.errors.messages.keys
      return @response = required_fields('REV_02', get_blank_fields(@review, fields)) if validate_empty_model_fields?(@review, fields)
    end
  end

  def reviews; end

  private

  def set_product
    params_validation(:product_id, 'PRO')
    return json_response(:set_product, :bad_request) if @response&.any?

    get_record_by_id(Product, :set_product, :product_id, 'PRO')
  end

  def set_category
    params_validation(:category_id, 'CAT')
    return json_response(:set_category, :bad_request) if @response&.any?

    get_record_by_column(ProductCategory, :set_category, :category_id, 'CAT')
  end

  def set_department
    params_validation(:department_id, 'DEP')
    return json_response(:set_department, :bad_request) if @response&.any?

    get_record_by_column(Category, :set_department, :department_id, 'DEP')
  end

  def product_params
    params.permit(
      :page,
      :limit,
      :description_length,
      :product_id,
      :category_id,
      :deparment_id,
      :query_string,
      :all_words
    )
  end

  def review_params
    params.permit(:review, :rating, :product_id)
  end

  def order_column
    params[:order] ||= 'category_id'
  end

  def product_offset
    params[:page] ||= 1
    params[:page].to_i * product_limit.to_i - 20
  end

  def product_limit
    params[:limit] = 20 if params[:limit].to_i.zero? || params[:limit].to_i < 20 || params[:limit].blank?
    params[:limit]
  end

  def description_length
    params[:description_length] = 200 if params[:description_length].to_i.zero? || params[:description_length].to_i < 200
    params[:description_length]
  end

  def all_words
    %i[on off].include? params[:all_words] || 'on'
  end
end
