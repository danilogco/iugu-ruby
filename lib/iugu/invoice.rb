# frozen_string_literal: true

module Iugu
  class Invoice < APIResource
    include Iugu::APIFetch
    include Iugu::APICreate
    include Iugu::APISave
    include Iugu::APIDelete

    def customer
      return false unless @attributes["customer_id"]

      Customer.fetch @attributes["customer_id"]
    end

    def cancel
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("PUT",
                                                                 "#{self.class.url(id)}/cancel"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def capture
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/capture"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def refund
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/refund"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def duplicate(attributes = {})
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/duplicate",
                                                                 attributes))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end
  end
end
