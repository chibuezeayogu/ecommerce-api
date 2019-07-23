# frozen_string_literal: true

class TaxesController < ApplicationController
  before_action :set_tax, only: :show

  def index
    @taxes = Tax.all
    unless @taxes.any?
      @response = response_message('TAX_03', 'Taxes field is empty.', 'Taxes', 404)
      status = :not_found
    end
    json_response(:index, status || :ok)
  end

  def show; end

  private

  def set_tax
    params_validation(:tax_id, 'TAX')
    return json_response(:set_tax, :bad_request) if @response&.any?

    get_record_by_id(Tax, :set_tax, :tax_id, 'TAX')
  end

  def tax_params
    params.permit(:tax_id)
  end
end
