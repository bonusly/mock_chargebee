module MockChargebee
  module Validations
    module Webhooks
      class EventAttributes
        ALLOWED_KEYS = %w[id occurred_at source user api_version webhooks]

        def self.validate_allowed(attributes)
          attributes.keys.each do |key|
            raise InvalidEventAttribute.new(key) unless ALLOWED_KEYS.include?(key)
          end
        end
      end
    end
  end
end
