# frozen_string_literal: true

if !@departments.empty?
  json.error @response
else
  json.array! @departments, :department_id, :name, :description
end
