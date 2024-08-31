# frozen_string_literal: true

module Schemas
  class Errors < StandardError
    attr_reader :errors

    def initialize(errors:)
      super
      @errors = errors
    end
  end
end
