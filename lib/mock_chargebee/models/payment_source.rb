# frozen_string_literal: true

module MockChargebee
  module Models
    class PaymentSource < Base
      RESOURCE_ID_PREFIX = 'payment_source'

      load_fixtures :payment_source

      def self.find(id)
        repositories.payment_sources.fetch(id)
      end

      def self.create(params)
        already_exists!(params['reference_id']) if already_exists?(params['reference_id'])

        params['id'] = unique_id
        source = payment_source_fixture.merge(params)
        repositories.payment_sources.store(source['id'], source)

        source
      end

      def self.already_exists?(ref_id)
        return false if ref_id.nil?

        repositories.payment_sources.values.include?(ref_id)
      end
    end
  end
end
