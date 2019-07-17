# frozen_string_literal: true

module Response
  extend ActiveSupport::Concern

  def json_response(action, status = :ok)
    render action, status: status
  end
end
