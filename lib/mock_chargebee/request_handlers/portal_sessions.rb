# frozen_string_literal: true

module MockChargebee
  module RequestHandlers
    class PortalSession < Base
      private

      def post
        portal_session = Models::PortalSession.create(params)
        { portal_session: portal_session }
      end
    end
  end
end
