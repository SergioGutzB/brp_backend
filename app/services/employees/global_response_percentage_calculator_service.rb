# frozen_string_literal: true

module Employees
  class GlobalResponsePercentageCalculatorService
    def initialize(company_id)
      @company_id = company_id
    end

    def execute!
      @company = Company.find_by(id: @company_id)
      calculate_percentages
    end

    private

    def calculate_percentages # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      total_responses = Hash.new(0)
      total_questions = Hash.new(0)

      @company.employee_profiles.find_each do |profile|
        calculator = ::Employees::ResponsePercentageCalculatorService.new(profile)
        employee_percentages = calculator.execute!

        form_type_key = profile.form_type.name
        question_counts_for_form_type = ::Employees::ResponsePercentageCalculatorService::QUESTIONS_COUNT[form_type_key] || {}

        question_counts_for_form_type.each do |type, total_questions_for_type|
          answered = employee_percentages[type] || 0
          total_responses[type] += answered
          total_questions[type] += total_questions_for_type
        end
      end

      percentages = {}
      total_questions.each do |type, total|
        answered = total_responses[type]
        percentage = (answered.to_f / total * 100).round(2)
        percentages[type] = percentage
      end

      percentages
    end
  end
end
