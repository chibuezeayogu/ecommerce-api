# frozen_string_literal: true

if @response&.any?
  json.error @response
else
  json.customer do
    json.schema @customer.attributes.except('password_digest')
  end
  json.set! :accessToken, "Bearer #{@token}"
  json.set! :expiresIn, '24h'
end
