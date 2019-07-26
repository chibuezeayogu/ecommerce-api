# frozen_string_literal: true

class StripeController < ApplicationController
  before_action :authenticate_request, only: :charge

  def charge
    fields = %i[stripeToken order_id description amount]
    @response = required_fields('STR_02', validates_required_fields(fields, params)) unless validates_required_fields(fields, params).empty?
    return if @response&.any?

    @order = Order.find_by(order_id: params[:order_id])
    if @order.nil?
      @response = response_message(
        'ORD_02',
        "Order with order_id=#{params[:order_id]} does not exist.",
        'order_id',
        404
      )
      return json_response(:charge, :not_found)
    end

    @request = Stripe::Charge.create(
      amount: params[:amount],
      currency: params[:currency] || 'usd',
      description: params[:description],
      source: params[:stripeToken],
      metadata: { 'order_id' => params[:order_id] }
    )

    if @request['status'] != 'succeeded'
      json_response(:charge, :bad_request)
    else
      @order.update(total_amount: params[:amount], status: 1)
      json_response(:charge)
    end
  end

  def webhooks; end

  private

  def stripe_params
    params.permit(
      :stripeToken,
      :order_id,
      :description,
      :amount,
      :currency
    )
  end
end
