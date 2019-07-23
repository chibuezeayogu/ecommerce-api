# frozen_string_literal: true

class ApplicationController < ActionController::API
  require 'json_web_token'
  include Response
  include Validations
  include RecordQueries
  include ExceptionHandler

  attr_reader :current_user

  private

  def authenticate_request
    http_token
    @current_user ||= Customer.find(decode_token[0]['id']) if decode_token
  rescue ActiveRecord::RecordNotFound
    raise(ExceptionHandler::InvalidToken, 'invalid user token')
  end

  def http_token
    return request.headers['USER-KEY'].split(' ').last if request.headers['USER-KEY'].present?

    raise(ExceptionHandler::MissingToken, 'No token provided')
  end

  def decode_token
    @decode_token ||= JsonWebToken.decode(http_token)
  rescue StandardError
    raise(ExceptionHandler::DecodeError, 'Token has expired or is invalid')
  end
end
