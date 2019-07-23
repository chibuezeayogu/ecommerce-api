# frozen_string_literal: true

if @response&.any?
  json.error @response
else
  json.array! @taxes
end
