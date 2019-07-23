# frozen_string_literal: true

module Validations
  extend ActiveSupport::Concern

  def params_validation(target_id, code)
    @response = response_message("#{code}_01", "#{target_id} is required.", target_id.to_s, 400) if params[target_id].blank?

    @response ||= response_message("#{code}_01", "#{target_id} is not a number.", target_id.to_s, 400) if params[target_id].to_i.zero?
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
