# frozen_string_literal: true

module Iugu
  class Utils
    def self.auth_from_env
      api_key = ENV["IUGU_API_KEY"]
      Iugu.api_key = api_key if api_key
    end

    def self.intersect(array, another_hash)
      keys_intersection = array & another_hash.keys
      intersection = {}
      keys_intersection.each { |k| intersection[k] = another_hash[k] }
      intersection
    end

    def self.underscore(string)
      string.gsub(/::/, "/")
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr("-", "_")
            .downcase
    end

    def self.camelize(string)
      string.to_s.gsub(%r{/(.?)}) do
        "::#{Regexp.last_match(1).upcase}"
      end.gsub(/(?:^|_)(.)/) { Regexp.last_match(1).upcase }
    end

    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[key.to_s] = if value.is_a? Hash
          stringify_keys(value)
        else
          value
        end
      end
      new_hash
    end
  end
end
