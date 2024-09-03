# frozen_string_literal: true

require 'exception_error'
require 'detailed_validation_error'

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ArgumentError, with: :unprocessable_entity
    rescue_from NoMethodError, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotUnique, with: :unique_error
    rescue_from ExceptionError, with: :exception_errors
    rescue_from JWT::ExpiredSignature, with: :jwt_expired_signature
    rescue_from DetailedValidationError, with: :detailed_validation_error
  end

  private

  def unprocessable_entity(exception)
    render json: build_message(exception.message, code: :unprocessable_entity), status: :unprocessable_entity
  end

  def unique_error(exception)
    result = extract_model_attribute_and_value(exception.to_s)
    model, attribute, value = result.values_at(:model, :attribute, :value)

    message = [build_message(I18n.t('errors.messages.uniqueness', attribute:), code: :unique)]
    render json: custom_error(model, message, value), status: :unprocessable_entity
  end

  def not_found(exception)
    render json: not_found_error(exception), status: :not_found
  end

  def detailed_validation_error(exception)
    if exception.is_a?(ActiveRecord::RecordInvalid)
      exception = DetailedValidationError.new(exception.record.errors.messages, exception.record.class.name.underscore)
    end

    render json: {
      errors: exception.messages.map do |field, messages|
        {
          attribute: exception.model,
          field:,
          messages: messages.map { |msg| build_message(msg, code: "invalid_#{ field }") }
        }
      end
    }, status: :unprocessable_entity
  end

  def extract_model_attribute_and_value(error_message)
    model = error_message[/index_(\w+)_on_/, 1]&.singularize&.capitalize

    if error_message =~ /Key \((\w+)\)=\((\d+)\)/
      attribute = ::Regexp.last_match(1)
      value = ::Regexp.last_match(2)
    end

    { model:, attribute:, value: }
  end

  def not_found_error(exception)
    message = [build_message(I18n.t('errors.messages.not_found', model: exception.model), code: :not_found)]
    custom_error(exception.model.try(:underscore), message)
  end

  def jwt_expired_signature
    render json: custom_error(
      'authentication',
      [build_message(I18n.t('errors.messages.jwt_expired'), code: 'jwt_expired')]
    ),
      status: :unauthorized
  end

  def class_name
    @class_name ||= controller_name.singularize.underscore
  end

  def build_message(msg, code: class_name)
    { code:, description: msg }
  end

  def custom_error(attribute, msg, value: nil)
    { errors: [{ attribute:, value:, messages: msg }] }
  end

  def exception_errors(exception)
    render json: custom_error(
      exception.model,
      build_message(exception.message, code: exception.code)
    ),
      status: :unprocessable_entity
  end
end
