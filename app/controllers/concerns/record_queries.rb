# frozen_string_literal: true

module RecordQueries
  extend ActiveSupport::Concern

  def get_record_by_id(model, action, target_id, code)
    @response = model.find(params[target_id])
  rescue ActiveRecord::RecordNotFound
    @response = response_message(
      "#{code}_02",
      "#{model.name} with #{target_id}=#{params[target_id]} does not exist.",
      target_id,
      404
    )
    json_response(action, :not_found)
  end

  def get_record_by_column(model, action, target_id, code)
    @response = model.where("#{target_id} = ?", params[target_id])

    if @response.empty?
      @response = response_message(
        "#{code}_02",
        "#{model.name} with #{target_id}=#{params[target_id]} does not exist.",
        target_id,
        404
      )
      json_response(action, :not_found)
    end
  end
end
