json.error do
  json.set! :status, 400
  json.set! :code, 'PRO_02'
  json.set! :message, 'Search field cannot be blank'
  json.set! :field, 'search'
end
