# frozen_string_literal: true

module MockChargebee
  module Validations
    module Subscriptions
      class CreateParams < Base
        REQUIRED_KEYS = %w[plan_id]
      end
    end
  end
end
