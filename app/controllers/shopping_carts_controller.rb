# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: %i[show delete_cart total_amount get_saved_cart]
  before_action :set_item, only: %i[update_cart move_to_cart save_for_later remove_product_from_cart]

  def create
    @shopping_cart = ShoppingCart.new(shopping_cart_params)

    return json_response(:create, :created) if @shopping_cart.save

    custom_validation
  end

  def generate_cart_id
    @response = SecureRandom.hex(10)
  end

  def show
    @cart_items = ShoppingCart.where(cart_id: params[:cart_id])
  end

  def update_cart
    if params[:quantity].blank? || params[:quantity]&.blank?
      @error = {
        status: 400,
        code: 'SHC_02',
        message: 'Quantity is required and cannot be blank',
        field: 'quantity'
      }
      return json_response(:update_cart, :bad_request)
    end

    @response.update(quantity: params[:quantity])
    json_response(:update_cart)
  end

  def delete_cart
    ShoppingCart.where(cart_id: params[:cart_id]).delete_all
    json_response(:delete_cart)
  end

  def move_to_cart
    @response.update(buy_now: true, added_on: DataTime.current)
    json_response(:move_to_cart)
  end

  def total_amount
    @total_amount = ShoppingCart
                    .joins(:product)
                    .where(cart_id: params[:cart_id], buy_now: true)
                    .sum('product.price * shopping_cart.quantity')
    json_response(:total_amount)
  end

  def save_for_later
    @response.update(buy_now: true, quantity: 1)
    json_response(:save_for_later)
  end

  def get_saved_cart
    @cart_item = ShoppingCart
                 .joins(:product)
                 .select('shopping_cart.item_id, product.name, shopping_cart.features, product.price')
                 .where(cart_id: 'ae3b69520b8d9c55db4e', buy_now: true)
  end

  def remove_product_from_cart
    @response.delete
    json_response(:remove_product_from_cart)
  end

  private

  def shopping_cart_params
    params.permit(
      :item_id,
      :cart_id,
      :product_id,
      :features,
      :quantity
    )
  end

  def set_item
    params_validation(:item_id, 'SHC')
    return json_response(:set_item, :bad_request) if @response&.any?

    get_record_by_id(ShoppingCart, :set_item, :item_id, 'SHC')
  end

  def set_cart
    if params[:cart_id].blank?
      @response = {
        status: 400,
        code: 'SHC_02',
        message: 'cart_id is required',
        field: 'cart_id'
      }
      return json_response(:set_cart, :bad_request)
    end

    get_record_by_column(ShoppingCart, :set_cart, :cart_id, 'SHC')
  end

  def custom_validation
    fields = @shopping_cart.errors.messages.keys
    @response = required_fields('SHC_02', get_blank_fields(@shopping_cart, fields)) if validate_empty_model_fields?(@shopping_cart, fields)
    json_response(:create, :bad_request)
  end
end
