# frozen_string_literal: true

module TokenGeneratorHelper
  def token_generator(customer)
    JsonWebToken.encode(id: customer.customer_id, email: customer.email)
  end

  def valid_header
    {
      'USER-KEY' => token_generator(customer),
      'Content-Type' => 'application/json'
    }
  end

  def invalid_headers
    {
      'Content-Type' => 'application/json'
    }
  end
end
