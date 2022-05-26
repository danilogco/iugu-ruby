# frozen_string_literal: true

module Iugu
  module APISave
    def save
      method = is_new? ? "POST" : "PUT"
      copy Iugu::Factory.create_from_response(self.class.object_type,
                                              APIRequest.request(method,
                                                                 self.class.url(attributes),
                                                                 modified_attributes))
      self.errors = nil
      true
    rescue Iugu::RequestWithErrors => e
      self.errors = e.errors
      false
    end
  end
end
