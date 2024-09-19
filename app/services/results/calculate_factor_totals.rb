# frozen_string_literal: true

module Results
  class CalculateFactorTotals
    def initialize(questionnaire, form_type, dimension_scores)
      @questionnaire = questionnaire
      @form_type = form_type
      @dimension_scores = dimension_scores
    end

    def call
      if questionnaire == 'FRPI'
        frpi_totals
      else
        dimension_scores
      end
    end

    private

    attr_reader :questionnaire, :form_type, :dimension_scores

    def frpi_totals
      score = total_score(dimension_scores)
      raw_score = total_frpi_raw_score(score)

      totals = {}
      totals[:score] = score
      totals[:raw] = raw_score
      totals[:risk] = domain_risk(raw_score * 100)

      totals
    end

    def total_score(dimensions)
      dimensions.sum { |_key, value| value[:score] }
    end

    def total_frpi_raw_score(score)
      factor = build_factor_klass::TRANSFORMATION_TOTAL_FACTORS
      factor = factor[form_type.to_sym]
      (score.to_f / factor).round(3)
    end

    def domain_risk(score)
      klass = Results::Risks::AFrpi
      klass.new(score).call
    end

    def build_factor_klass
      "Results::Factors::#{ questionnaire.capitalize }".constantize
    end
  end
end
