# frozen_string_literal: true

module Iugu
  module APICreate
    module ClassMethods
      def search(options = {})
        Iugu::Factory.create_from_response object_type, APIRequest.request("GET", url(options), options)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
