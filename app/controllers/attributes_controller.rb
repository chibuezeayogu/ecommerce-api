# frozen_string_literal: true

class AttributesController < ApplicationController
  before_action :set_attribute, only: :show
  before_action :set_attribute_value, only: :values
  before_action :set_product, only: :in_product

  def index
    @attributes = Attribute.all
    unless @attributes.any?
      @response = response_message('ART_03', 'Attributes field is empty.', 'Attributes', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def show; end

  def values; end

  def in_product
    @product_attributes = []
    @response.attribute_values.includes(:feature).each do |attribute_value|
      @product_attributes << {
        attribute_name: attribute_value.feature.name,
        attribute_value_id: attribute_value.attribute_value_id,
        attribute_value: attribute_value.value
      }
    end
    @product_attributes
  end

  private

  def set_attribute
    params_validation(:attribute_id, 'ART')
    return json_response(:set_attribute, :bad_request) if @response&.any?

    get_record_by_id(Attribute, :set_attribute, :attribute_id, 'ART')
  end

  def set_attribute_value
    params_validation(:attribute_id, 'ART')
    return json_response(:set_attribute_value, :bad_request) if @response&.any?

    get_record_by_column(AttributeValue, :set_attribute_value, :attribute_id, 'ART')
  end

  def set_product
    params_validation(:product_id, 'PRO')
    return json_response(:set_product, :bad_request) if @response&.any?

    get_record_by_id(Product, :set_product, :product_id, 'PRO')
  end

  def attribute_params
    params.permit(:attribute_id, :category_id)
  end
end
