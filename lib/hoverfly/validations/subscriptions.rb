module Hoverfly
  module Validations
    module Subscriptions
      class CreateParams
        REQUIRED_KEYS = ["plan_id"]

        def self.validate(params)
          raise ChargeBee::InvalidRequestError.new(400, "Required key missing") unless REQUIRED_KEYS.all? { |required_key| params.has_key?(required_key) }
        end
      end
    end
  end
end
