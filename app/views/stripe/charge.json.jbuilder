# frozen_string_literal: true

if @response&.any?
  json.error @response
elsif @request['status'] != 'succeeded'
  json.set! :status, 400
  json.set! :code, 'STR_01'
  json.set! :message, 'There was an error processing your payment'
  json.set! :field, 'stripeToken'
else
  json.data @request
end
