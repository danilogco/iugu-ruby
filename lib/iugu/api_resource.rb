# frozen_string_literal: true

module Iugu
  class APIResource < Iugu::Object
    def self.url(options = nil)
      endpoint_url + relative_url(options)
    end

    def is_new?
      @attributes["id"].nil?
    end

    def self.object_type
      Iugu::Utils.underscore name.to_s.split("::")[-1]
    end

    def self.endpoint_url
      "#{Iugu.base_uri}#{self.object_base_uri}"
    end

    def self.relative_url(options = "")
      id = case options
           when Hash
             options[:id] || options["id"]
           when Iugu::APIResource
             options.id
           else
             options
      end
      id ? "/#{id}" : ""
    end

    def self.object_base_uri
      pluralized_models = ["account", "customer", "payment_method", "invoice", "subscription", "plan"]
      if pluralized_models.include? self.object_type
        "#{self.object_type}s"
      else
        object_type
      end
    end
  end
end
