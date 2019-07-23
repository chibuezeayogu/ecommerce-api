# frozen_string_literal: true

class ErrorsController < ApplicationController
  def route_not_found
    @response = {
      status: 404,
      code: 'ROT_02',
      message: 'Route not found'
    }
    json_response(:route_not_found, :bad_request)
  end
end
