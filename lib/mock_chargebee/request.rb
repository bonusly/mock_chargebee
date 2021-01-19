# frozen_string_literal: true

module MockChargebee
  module Request
    def self.request(method, url, _env, params = {}, _headers = {})
      parsed_path = Util.parse_path_from_url(url)
      parsed_params = Util.parse_params(params)

      handler = RequestHandlers.const_get(parsed_path.resource.capitalize)
      resp = handler.call(method, parsed_path, parsed_params)
      resp = ChargeBee::Util.symbolize_keys(resp)
      resp
    rescue NameError => e
      raise MockChargebee::MissingRequestHandler parsed_path.resource if e.message.match?(/uninitialized constant #{parsed_path.resource.capitalize}/)

      raise e
    end
  end
end
