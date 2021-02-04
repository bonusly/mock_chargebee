# frozen_string_literal: true

module MockChargebee
  module Validations
    module PortalSessions
      class CreateParams < Base
        REQUIRED_KEYS = %w[customer].freeze
      end
    end
  end
end
