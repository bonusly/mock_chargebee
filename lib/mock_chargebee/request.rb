# frozen_string_literal: true

module MockChargebee
  module Request
    def self.request(method, url, _env, params = {}, _headers = {})
      parsed_path = Util.parse_path_from_url(url)
      parsed_params = Util.parse_params(params)

      handler = RequestHandlers.const_get(parsed_path.resource.split('_').map(&:capitalize).join(''))
      resp = handler.call(method, parsed_path, parsed_params)
      ChargeBee::Util.symbolize_keys(resp)
    rescue NameError => e
      if e.message.match?(/uninitialized constant #{parsed_path.resource.capitalize}/)
        raise MockChargebee::MissingRequestHandler parsed_path.resource
      end

      raise e
    end
  end
end
