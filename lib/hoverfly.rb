require "#{File.dirname(__FILE__)}/hoverfly/environment"
require "#{File.dirname(__FILE__)}/hoverfly/errors"
require "#{File.dirname(__FILE__)}/hoverfly/repositories"
require "#{File.dirname(__FILE__)}/hoverfly/request"
require "#{File.dirname(__FILE__)}/hoverfly/util"

Dir.glob("#{File.dirname(__FILE__)}/hoverfly/request_handlers/**/*.rb").sort.each(&method(:require))

module Hoverfly
  @state = :ready

  def self.start
    return false if @state = :started

    @@environment = Environment.new
    @orginal_chargebee_request = ChargeBee::Rest.method(:request)
    ChargeBee::Rest.define_singleton_method(:request, &Hoverfly::Request.request)
    @state = :started
  end

  def self.stop
    @@environment = nil
    ChargeBee::Rest.define_singleton_method(:request, &@@original_chargebee_request)
    @original_chargebee_request = nil
    @state = :ready
  end

  def self.environment
    @@environment
  end
end
