# frozen_string_literal: true

module MockChargebee
  module Models
    class PortalSession < Base
      RESOURCE_ID_PREFIX = 'portal'

      load_fixtures :portal_session

      def self.create(params)
        Validations::PortalSessions::CreateParams.validate_required(params)

        params['id'] ||= unique_id
        params['customer_id'] = params.dig(:customer, :id)
        portal_session = portal_session_fixture.merge(params)
        repositories.portal_sessions.store(portal_session['id'], portal_session)

        portal_session
      end
    end
  end
end
