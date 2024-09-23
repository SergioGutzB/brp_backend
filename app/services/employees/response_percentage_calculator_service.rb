# frozen_string_literal: true

module Employees
  class ResponsePercentageCalculatorService
    QUESTIONS_COUNT = {
        'A' => { 'FRPI' => 123, 'FRPE' => 31, 'EE' => 31 },
        'B' => { 'FRPI' => 97, 'FRPE' => 31, 'EE' => 31 }
    }.freeze

    def initialize(employee_profile_id)
      @employee_profile_id = employee_profile_id
    end

    attr_reader :employee_profile

    def execute!
      @employee_profile = EmployeeProfile.find_by(id: @employee_profile_id)

      calculate_response_percentages
    end

    private

    def calculate_response_percentages # rubocop:disable Metrics/AbcSize
      response_counts = employee_profile.responses_count_by_questionnaire

      form_type_key = employee_profile.form_type.name # Assuming 'name' is either 'A' or 'B'

      question_counts_for_form_type = QUESTIONS_COUNT[form_type_key] || {}

      percentages = {}

      question_counts_for_form_type.each do |type, total_questions|
        answered = response_counts[type] || 0
        percentage = (answered.to_f / total_questions * 100).round(2)
        percentages[type.to_sym] = percentage
      end

      total = percentages.values.sum

      percentages[:total] = (total.to_f / 3).round(2)

      percentages
    end
  end
end
