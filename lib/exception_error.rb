# frozen_string_literal: true

class ExceptionError < StandardError
  attr_reader :model, :code, :message

  def initialize(message = nil, model = nil, code = 'invalid')
    @model = model
    @code = code

    super(message)
  end
end
