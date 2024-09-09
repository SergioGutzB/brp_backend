# frozen_string_literal: true

module Responses
  class CreateService
    def initialize(employee_profile_id:, question_id:, brp_id:, answer:)
      @employee_profile_id = employee_profile_id
      @question_id = question_id
      @brp_id = brp_id
      @answer = answer
    end

    def call
      response = create_question

      if response.save
        { success: true, response: }
      else
        { success: false, errors: response.errors.full_messages }
      end
    end

    private

    def create_question
      brp = Brp.find(@brp_id)
      question = Question.find(@question_id)
      employee_profile = EmployeeProfile.find(@employee_profile_id)

      Response.create!(
        brp:,
        question:,
        employee_profile:,
        answer: @answer
      )
    rescue ActiveRecord::RecordInvalid => exception
      raise DetailedValidationError.new(exception.record.errors.messages, exception.record.class.name.underscore)
    end
  end
end
