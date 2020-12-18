# frozen_string_literal: true

module Hoverfly
  module Util
    def self.parse_path_from_url(url)
      ParsedPath.new(*url.delete_prefix("/").split("/"))
    end

    def self.parse_params(params)
      params = Rack::Utils.parse_nested_query(params.to_query)
      deep_transform_values!(params)
    end

    ParsedPath = Struct.new(:resource, :id, :rest) do
      def sub_command
        rest.nil? ? nil : "_#{rest}"
      end
    end

    def self.generate_id(resource_prefix)
      "__TEST__#{resource_prefix}__#{SecureRandom.uuid}"
    end

    def self.deep_transform_values!(hash)
      hash.reduce({}) do |hash, pair|
        key, val = pair
        val = deep_transform_values!(val) if val.is_a?(Hash)
        val = true if val == "true"
        val = false if val == "false"
        val = 0 if val == "0"
        val = val.to_f if key.match?(/decimal/)
        val = val.to_i if (val.to_i != 0 && !key.match?(/id/) && !key.match?(/decimal/))
        hash.store(key, val)
        hash
      end
    end
  end
end
