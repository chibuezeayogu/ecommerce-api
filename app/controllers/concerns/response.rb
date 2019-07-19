# frozen_string_literal: true

module Response
  extend ActiveSupport::Concern

  def json_response(action, status = :ok)
    render action, status: status
  end

  def response_message(code, message, field, status)
    {
      status: status,
      code: code,
      message: message,
      fields: field
    }
  end
end
