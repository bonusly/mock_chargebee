# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/mock_chargebee/environment"
require "#{File.dirname(__FILE__)}/mock_chargebee/errors"
require "#{File.dirname(__FILE__)}/mock_chargebee/repositories"
require "#{File.dirname(__FILE__)}/mock_chargebee/request"
require "#{File.dirname(__FILE__)}/mock_chargebee/util"
require "#{File.dirname(__FILE__)}/mock_chargebee/webhook"

Dir.glob("#{File.dirname(__FILE__)}/mock_chargebee/request_handlers/**/*.rb").sort.each(&method(:require))
Dir.glob("#{File.dirname(__FILE__)}/mock_chargebee/validations/**/*.rb").sort.each(&method(:require))
Dir.glob("#{File.dirname(__FILE__)}/mock_chargebee/models/**/*.rb").sort.each(&method(:require))
Dir.glob("#{File.dirname(__FILE__)}/mock_chargebee/services/**/*.rb").sort.each(&method(:require))

module MockChargebee
  @@state = :ready
  @@environment = nil
  @@original_chargebee_request = nil

  def self.start
    return false if @@state == :started

    @@environment = Environment.new
    @@original_chargebee_request = ChargeBee::Rest.method(:request)
    ChargeBee::Rest.define_singleton_method(:request, &MockChargebee::Request.method(:request))
    @@state = :started
  end

  def self.stop
    @@environment = nil
    ChargeBee::Rest.define_singleton_method(:request, &@@original_chargebee_request)
    @@original_chargebee_request = nil
    @@state = :ready
  end

  def self.mock_webhook_payload_for(event_type, event_attributes: {}, content_attributes: {})
    Webhook.new(event_type, event_attributes, content_attributes).call
  end

  def self.environment
    @@environment
  end
end
