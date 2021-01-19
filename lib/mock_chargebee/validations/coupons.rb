# frozen_string_literal: true

module MockChargebee
  module Validations
    module Coupons
      class CreateParams < Base
        REQUIRED_KEYS = %w[id name discount_type apply_on duration_type]
      end
    end
  end
end
