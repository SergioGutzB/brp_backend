# frozen_string_literal: true

module Brps
  class CreateService
    def initialize(params)
      @company_id = params[:company_id]
      @year = params[:year]
    end

    def execute!
      company = Company.find(@company_id)

      Brp.create!(company:, year: @year)
    rescue ActiveRecord::RecordInvalid => exception
      raise DetailedValidationError.new(exception.record.errors.messages, exception.record.class.name.underscore)
    end
  end
end
