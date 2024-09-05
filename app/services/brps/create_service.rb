# frozen_string_literal: true

module Brps
  class CreateService
    def initialize(params)
      @params = params
    end

    def execute!
      Brp.create!(@params)
    end
  end
end
