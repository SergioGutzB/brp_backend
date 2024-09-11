# frozen_string_literal: true

# Internal:
# Paso 1. Calificación de los ítems
# pag 76
#
module Responses
  class CalculateResponseTotalService
    ANSWER_OPTIONS = ['always', 'almost_always', 'sometimes', 'almost_never', 'never'].freeze

    def initialize(form_type, questionnaire_name, question_number, response_value)
      @form_type = form_type # A | B
      @question_number = question_number
      @response_value = response_value
      @questionnaire_name = questionnaire_name
    end

    def call
      options_module = get_options_module(@questionnaire_name)

      multiplier = find_multiplier_for_question(options_module)
      calculate_total(multiplier)
    end

    private

    def get_options_module(questionnaire_name)
      module_name = "Responses::#{ questionnaire_name.capitalize }Options"
      module_name.constantize
    end

    def find_multiplier_for_question(options_module)
      question_multipliers = options_module.const_get("QUESTION_MULTIPLIERS_#{ @form_type.upcase }")

      category = question_multipliers.values.find do |cat|
        cat[:questions].include?(@question_number)
      end

      category ? category[:multipliers] : 0
    end

    def calculate_total(multiplier)
      multiplier[@response_value]
    end
  end
end
