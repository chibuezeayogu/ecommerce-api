# frozen_string_literal: true

module Validation
  extend ActiveSupport::Concern

  def params_validation(model, action, target_id, code, params)
    if params[target_id].blank?
      @response = response_message("#{code}_01", "#{target_id} is required.", target_id.to_s, 400)
      return json_response(action, :bad_request)
    end

    if params[target_id].to_i.zero?
      @response = response_message("#{code}_01", "#{target_id} is not a number.", target_id.to_s, 400)
      return json_response(action, :bad_request)
    end

    @response = model.find(params[target_id].to_i)
  rescue ActiveRecord::RecordNotFound
    @response = response_message(
      "#{code}_02",
      "#{model.name} with #{target_id}=#{params[target_id]} does not exist.",
      target_id.to_s,
      404
    )
    json_response(action, :not_found)
  end

  def validate_empty_model_fields?(object, fields)
    fields = get_blank_fields(object, fields)
    return true if fields.any?

    false
  end

  def get_blank_fields(object, fields)
    fields.delete_if { |column| object.errors.added?(column, :blank) == false }
  end

  def key_exist?(object, column, error)
    return true if object.errors.details.key?(column) && object.errors.details[column].first.value?(error)

    false
  end

  def validates_required_fields(fields, params)
    fields.reject! { |field| params.include?(field) }
    fields
  end

  def validates_empty_fields(fields, params)
    fields.select! { |field| params[field]&.blank? }
    fields
  end
end
