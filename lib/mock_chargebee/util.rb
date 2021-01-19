# frozen_string_literal: true

module MockChargebee
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
      hash.each_with_object({}) do |pair, hash|
        key, val = pair

        next hash.store(key, val) if key.match?(/id/)

        case val
        when Hash
          transformed_val = deep_transform_values!(val)
          hash.store(key, transformed_val)
        when "true"
          hash.store(key, true)
        when "false"
          hash.store(key, false)
        when /^\d+\.\d+$/
          hash.store(key, val.to_f)
        when /^\d+$/
          hash.store(key, val.to_i)
        else
          hash.store(key, val)
        end
      end
    end
  end
end
