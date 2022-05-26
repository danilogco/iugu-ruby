# frozen_string_literal: true

module Iugu
  class SearchResult
    def initialize(results, total_results)
      @results = results
      @total = total_results
    end

    attr_reader :total, :results
  end
end
