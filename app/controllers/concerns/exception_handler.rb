# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class DecodeError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::DecodeError, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do
      json_response({ error: record_not_found }, :not_found)
    end
    # rescue_from ActiveRecord::RecordInvalid do |e|
    #   json_response({ message: e.message }, :unprocessable_entity)
    # end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(error)
    auth_response(
      {
        error: {
          status: 422,
          code: 'AUT_01',
          message: error,
          field: 'Header -> USER-KEY'
        }
      }, :unprocessable_entity
    )
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(_error)
    auth_response(
      {
        error: {
          status: 422,
          code: 'AUT_01',
          message: 'User could not be authenticated',
          field: 'Header -> USER-KEY'
        }
      }, :unauthorized
    )
  end

  def auth_response(object, status = :ok)
    render json: object, status: status
  end

  def record_not_found
    {
      status: 404,
      code: 'AUT_03',
      message: 'User is not registered',
      field: 'User'
    }
  end
end
