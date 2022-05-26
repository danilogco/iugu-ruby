# frozen_string_literal: true

module Iugu
  module APICreate
    module ClassMethods
      def create(attributes = {}, token = nil)
        Iugu::Factory.create_from_response(
          object_type,
          APIRequest.request('POST', url(attributes), attributes, token)
        )
      rescue Iugu::RequestWithErrors => e
        obj = new
        obj.set_attributes attributes, true
        obj.errors = e.errors
        obj
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
