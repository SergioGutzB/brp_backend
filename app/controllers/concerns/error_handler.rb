# frozen_string_literal: true

require 'exception_error'

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ArgumentError, with: :unprocessable_entity
    rescue_from NoMethodError, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ExceptionError, with: :exception_errors
  end

  private

  def unprocessable_entity(exception)
    render json: build_message(exception.message, code: :unprocessable_entity), status: :unprocessable_entity
  end

  def not_found(exception)
    render json: not_found_error(exception), status: :not_found
  end

  def unauthorized(exception)
    render json: build_message(exception.message, code: :unauthorized), status: :unauthorized
  end

  def not_found_error(exception)
    message = [build_message(I18n.t('errors.messages.not_found'), code: :not_found)]
    custom_error(exception.model.try(:underscore), message)
  end

  def class_name
    @class_name ||= controller_name.singularize.underscore
  end

  def build_message(msg, code: class_name)
    { code:, description: msg }
  end

  def custom_error(attribute, msg)
    { errors: [{ attribute:, messages: msg }] }
  end

  def exception_errors(exception)
    render json: custom_error(
      exception.model,
      build_message(exception.message, code: exception.code)
    ),
      status: :unprocessable_entity
  end
end
