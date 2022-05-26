# frozen_string_literal: true

module Iugu
  class PaymentMethod < APIResource
    include Iugu::APIFetch
    include Iugu::APICreate
    include Iugu::APISave
    include Iugu::APIDelete

    def self.url(options = {})
      customer_id = options[:customer_id] || options["customer_id"]
      id = options[:id] || options["id"]
      raise StandardError, "Missing Customer ID" unless customer_id

      "#{Customer.url customer_id}/#{object_base_uri}" + relative_url(id)
    end
  end
end
