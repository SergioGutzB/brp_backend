# frozen_string_literal: true

# Internal:
# Paso 1. Calificación de los ítems
# pag 76
#
module Responses
  class CalculateResponseTotalService
    ANSWER_OPTIONS = ['always', 'almost_always', 'sometimes', 'almost_never', 'never'].freeze
    NEGATIVE_RESPONSES_LRST_DE = [89, 90, 91, 92, 93, 94, 95, 96, 97].freeze
    NEGATIVE_RESPONSES_LRST_RC = [115, 116, 117, 118, 119, 120, 121, 122, 123].freeze

    def initialize(form_type:, questionnaire_name:, question_number:, answer:, negative_lrst_dc: false, negative_lrst_rc: false) # rubocop:disable Metrics/ParameterLists
      @form_type = form_type # A | B
      @question_number = question_number
      @response_value = answer
      @questionnaire_name = questionnaire_name
      @negative_lrst_dc = negative_lrst_dc
      @negative_lrst_rc = negative_lrst_rc
    end

    def call
      options_module = get_options_module(@questionnaire_name)
      multiplier = find_multiplier_for_question(options_module)

      return 0 if validate_negatives

      calculate_total(multiplier)
    end

    private

    attr_reader :negative_lrst_dc, :negative_lrst_rc

    def validate_negatives
      NEGATIVE_RESPONSES_LRST_DE.include?(@question_number) && negative_lrst_dc ||
        NEGATIVE_RESPONSES_LRST_RC.include?(@question_number) && negative_lrst_rc
    end

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
