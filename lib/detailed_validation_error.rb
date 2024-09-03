# frozen_string_literal: true

class DetailedValidationError < StandardError
  attr_reader :messages, :model

  def initialize(messages, model)
    @messages = messages
    @model = model
    super("Validation failed: #{ messages }")
  end
end
