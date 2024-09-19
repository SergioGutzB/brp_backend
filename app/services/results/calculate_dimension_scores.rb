# frozen_string_literal: true

module Results
  class CalculateDimensionScores
    def initialize(employee_profile, questionnaire)
      @employee_profile = employee_profile
      @responses = Response.where(employee_profile: @employee_profile)
      @form_type = @employee_profile.form_type.name
      @questionnaire = questionnaire # FRPI | FRPE | EE
    end

    def call
      if @questionnaire == 'EE'
        calculate_totals_for_ee(build_klass::DIMENSIONS)
      else
        calculate_totals(build_klass::DIMENSIONS)
      end
    end

    private

    def calculate_totals(dimensions)
      result = {}

      dimensions.each do |key, value|
        if @questionnaire == 'FRPI'
          result[key] = calculate_for_dimension_for_frpi(value, key)
        elsif @questionnaire == 'FRPE'
          result[key] = calculate_for_dimension_for_frpe(value, key)
        end
      end

      result
    end

    def calculate_totals_for_ee(dimensions)
      score = 0

      dimensions.each do |key, value|
        score += calculate_total_avegarage(value) * key.to_s.to_i
      end
      dimension_score = calculate_dimension_score_for_ee(score)

      {
        score:,
        dimension_score:
      }
    end

    def calculate_for_dimension_for_frpe(value, key)
      score = calculate_for_form_type(value)
      dimension_score = calculate_dimension_score_for_frpe(score, key)

      { score:, dimension_score: }
    end

    # Only for FRPI
    def calculate_for_dimension_for_frpi(dimensions, key)
      totals = {}

      dimensions.each do |sub_key, forms|
        score = calculate_for_form_type(forms[@form_type.to_sym])
        dimension_score = calculate_dimension_score_for_frpi(score, key, sub_key, @form_type.to_sym)

        totals[sub_key] = {
          score:,
          dimension_score:
        }
      end

      totals
    end

    def calculate_for_form_type(question_numbers)
      return 0 unless question_numbers

      question_ids = Question.where(
        number: question_numbers,
        form_type: FormType.find_by(name: @form_type),
        questionnaire: Questionnaire.find_by(abbreviation: @questionnaire)
      ).pluck(:id)

      @responses.where(question_id: question_ids).sum(:total)
    end

    def calculate_total_avegarage(question_numbers)
      calculate_for_form_type(question_numbers).to_f / question_numbers.count
    end

    # Pag. 81, Tabla 25: Factores de transformación para las dimensiones de las formas A y B.
    def calculate_dimension_score_for_frpi(score, key, dimension, form_type)
      factors = build_factor_klass::TRANSFORMATION_FACTORS
      factor = factors[key][dimension][form_type]
      calculate_factor(score, factor)
    end

    # Pag. 150
    def calculate_dimension_score_for_frpe(score, dimension)
      factors = build_factor_klass::TRANSFORMATION_FACTORS
      factor = factors[dimension]
      calculate_factor(score, factor)
    end

    def calculate_dimension_score_for_ee(score)
      factor = build_factor_klass::TRANSFORMATION_FACTORS
      calculate_factor(score, factor)
    end

    def calculate_factor(score, factor)
      (score.to_f / factor).round(3)
    end

    def build_factor_klass
      "Results::Factors::#{ @questionnaire.capitalize }".constantize
    end

    def build_klass
      "Results::Dimensions::#{ @questionnaire.capitalize }".constantize
    end
  end
end
