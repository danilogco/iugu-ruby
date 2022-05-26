# frozen_string_literal: true

module Iugu
  class Subscription < APIResource
    include Iugu::APIFetch
    include Iugu::APICreate
    include Iugu::APISave
    include Iugu::APIDelete

    def add_credits(quantity)
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("PUT",
                                                                 "#{self.class.url(id)}/add_credits",
                                                                 { quantity: quantity }))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def remove_credits(quantity)
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("PUT",
                                                                 "#{self.class.url(id)}/remove_credits",
                                                                 { quantity: quantity }))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def suspend
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/suspend"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def activate
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/activate"))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def change_plan(plan_identifier, options = {})
      options[:plan_identifier] = plan_identifier
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request("POST",
                                                                 "#{self.class.url(id)}/change_plan",
                                                                 options))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end

    def change_plan_simulation(plan_identifier, options = {})
      options[:plan_identifier] = plan_identifier
      Iugu::Factory.create_from_response(self.class.object_type,
                                         APIRequest.request("GET",
                                                            "#{self.class.url(id)}/change_plan_simulation",
                                                            options))
    end

    def customer
      return false unless @attributes["customer_id"]

      Customer.fetch @attributes["customer_id"]
    end
  end
end
