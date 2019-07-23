# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_request
  before_action :set_order_details, only: :show
  before_action :set_order, only: :short_details

  def create
    fields = {}
    order_params.each { |key, value| fields[key] = value if %i[shipping_id tax_id].include?(key.to_sym) }
    @order = Order.new fields
    @order.customer_id = @current_user.customer_id
    @cart_items = ShoppingCart.where(cart_id: params[:cart_id])

    if @cart_items.empty?
      @response = {
        status: 404,
        code: 'ORD_02',
        message: 'cart_id does not exist',
        field: 'cart_id'
      }
      return json_response(:create, :not_found)
    end
    order_details = OrderDetail.new(
      order_id: @order.order_id,
      product_id: @cart_items.product_id,
      features: @cart_items.features,
      product_name: @cart_items.product.name,
      quantity: @cart_items.quantity,
      unit_cost: @cart_items.product.price
    )

    if @order.save && order_details.save
      json_response(:create, :created)
    else
      custom_validation
    end
  end

  def show; end

  def show_customer_orders; end

  def short_details; end

  private

  def set_order
    params_validation(:order_id, 'ORD')
    return json_response(:set_order, :bad_request) if @response&.any?

    get_record_by_id(Order, :set_order, :order_id, 'ORD')
  end

  def set_order_details
    params_validation(:order_id, 'ORD')
    return json_response(:set_order_details, :bad_request) if @response&.any?

    get_record_by_column(OrderDetail, :set_order_details, :order_id, 'ORD')
  end

  def order_params
    params.permit(
      :order_id,
      :cart_id,
      :shipping_id,
      :tax_id,
      :total_amount,
      :shipped_on,
      :comment,
      :auth_code,
      :reference,
      :status
    )
  end

  def custom_validation
    fields = @order.errors.messages.keys
    @response = required_fields('ORD_02', get_blank_fields(@order, fields)) if validate_empty_model_fields?(@order, fields)
    json_response(:create, :bad_request)
  end
end
