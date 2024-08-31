# frozen_string_literal: true

module Schemas
  class ValidateJsonParameters
    def initialize(path:, parameters:)
      @path = path
      @parameters = parameters
    end

    def valid_json?
      return false unless validate_resources

      validate_schema.none?
    end

    def json_errors
      return file_error unless validate_resources

      errors = JsonErrors.new(errors: validate_schema)
      errors.build_errors_messages
    end

    private

    attr_reader :path, :parameters

    def validate_schema
      @validate_schema ||= assign_schema.validate(json_parameters)
    end

    def validate_resources
      File.exist?(path) && json_parameters
    end

    def assign_schema
      JSONSchemer.schema(File.read(path))
    end

    def json_parameters
      JSON.parse(parameters.to_json)
    rescue JSON::ParserError
      false
    end

    def file_error
      [{ attribute: :type, code: :invalid, message: I18n.t('errors.messages.invalid_json') }]
    end
  end
end
