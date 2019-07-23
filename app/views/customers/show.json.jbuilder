# frozen_string_literal: true

json.merge! @current_user.attributes.except('password_digest')
