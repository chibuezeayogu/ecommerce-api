# frozen_string_literal: true

class ShippingsController < ApplicationController
  before_action :set_shipping_region, only: %i[show]

  def index
    @shipping_regions = ShippingRegion.all
    if @shipping_regions.empty?
      @response = response_message('SHR_03', 'Shipping Regions field is empty.', 'Shipping Regions', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def show; end

  private

  def set_shipping_region
    params_validation(:shipping_region_id, 'SHR')
    return json_response(:set_shipping_region, :bad_request) if @response&.any?

    get_record_by_id(ShippingRegion, :set_shipping_region, :shipping_region_id, 'SHR')
  end

  def tax_params
    params.permit(:shipping_region_id)
  end
end
