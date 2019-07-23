# frozen_string_literal: true

require 'jwt'

class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  # Encodes and signs JWT Payload with expiration
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, HMAC_SECRET)
  end

  # Decodes the JWT with the signed secret
  def self.decode(token)
    JWT.decode(token, HMAC_SECRET)
  end

  # VAlidates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != mata[:aud]
      false
    else
      true
    end
  end

  # Default options to be encoded in the token
  def self.meta
    {
      exp: 1.day.from_now.to_i,
      iss: 'issuser_name',
      aud: 'client'
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.zone.at(payload['exp']) < Time.zone.now
  end
end
