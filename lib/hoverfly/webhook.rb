module Hoverfly
  class Webhook
    def initialize(event_type, event_attributes = {}, content_attributes = {})
      @event_type = event_type
      @event_attributes = event_attributes.stringify_keys
      @content_attributes = content_attributes.stringify_keys
    end

    def call
      Validations::Webhooks::EventAttributes.validate_allowed(event_attributes)

      event_attributes.merge!("content" => content_attributes)
      response = fixture.deep_merge(event_attributes)

      response.to_json
    end

    private

    attr_reader :event_type, :event_attributes, :content_attributes

    def fixture
      @fixture ||= JSON.parse(File.read("#{File.dirname(__FILE__)}/fixtures/webhooks/#{event_type}.json"))
    end
  end
end
