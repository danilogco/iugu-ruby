# frozen_string_literal: true

module Iugu
  module APIDelete
    def delete
      APIRequest.request("DELETE", self.class.url(attributes))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end
  end
end
