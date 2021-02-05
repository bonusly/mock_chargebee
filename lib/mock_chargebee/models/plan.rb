# frozen_string_literal: true

module MockChargebee
  module Models
    class Plan < Base
      RESOURCE_ID_PREFIX = 'plan'

      load_fixtures :plan

      def self.find(id)
        repositories.plans.fetch(id)
      end

      def self.create(params)
        params['id'] ||= unique_id
        plan = plan_fixture.merge(params)
        repositories.plans.store(plan['id'], plan)

        plan
      end

      def self.update(id, params)
        plan = find(id)
        plan.merge!(params)
        repositories.plans.store(plan['id'], plan)

        plan
      end
    end
  end
end
