# frozen_string_literal: true

if @response&.any?
  json.error @response
else
  json.merge! @current_user.attributes.except('password_digest')
end
