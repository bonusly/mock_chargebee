# frozen_string_literal: true

module MockChargebee
  module RequestHandlers
    class Plans < Base
      private

      def post
        plan = if id.nil?
                 Models::Plan.create(params)
               else
                 Models::Plan.update(id, params)
               end

        { plan: plan }
      end

      def get
        plan = Models::Plan.find(id)

        { plan: plan }
      end
    end
  end
end
