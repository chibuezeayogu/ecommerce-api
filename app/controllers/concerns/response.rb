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

  def required_fields(code, fields)
    {
      status: 400,
      code: code,
      message: 'The following field(s) are required',
      fields: fields.join(', ')
    }
  end

  def blank_fields(code, fields)
    {
      status: 400,
      code: code,
      message: 'The following field(s) cannot be blank',
      fields: fields.join(', ')
    }
  end
end
