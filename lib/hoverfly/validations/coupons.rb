# frozen_string_literal: true

module Hoverfly
  module Validations
    module Coupons
      class CreateParams
        REQUIRED_KEYS = ["id", "name", "discount_type", "apply_on", "duration_type"]

        def self.validate(params)
          raise ChargeBee::InvalidRequestError.new(400, "Required key missing") unless REQUIRED_KEYS.all? { |required_key| params.has_key?(required_key) }
        end
      end
    end
  end
end
