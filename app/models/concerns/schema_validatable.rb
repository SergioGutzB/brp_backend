# frozen_string_literal: true

module SchemaValidatable
  extend ActiveSupport::Concern

  def validate_schema(parameters:, schema: :user, model: :customs)
    schema = Schemas::ValidateJsonParameters.new(path: schema_path(schema, model), parameters:)
    return if schema.valid_json?

    raise Schemas::Errors.new(errors: include_errors(schema.json_errors))
  end

  def schema_path(schema, model)
    "#{ Rails.root }/app/models/schemas/#{ model }/#{ schema }.json"
  end

  def include_errors(errors)
    errors.map do |error|
      { attribute: error[:attribute], messages: [{ code: error[:code], description: error[:message] }] }
    end
  end
end
