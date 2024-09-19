# frozen_string_literal: true

module Results
  class CalculateDomainScores
    def initialize(dimension_scores, form_type, questionnaire)
      @dimension_scores = dimension_scores
      @form_type = form_type
      @questionnaire = questionnaire
    end

    def call
      calculate_totals
    end

    private

    attr_reader :dimension_scores, :form_type, :questionnaire

    def calculate_totals
      totals = {}
      dimension_scores.each do |domain, dimensions|
        score = total_score(dimensions)
        raw_score = total_raw_score(domain, score)
        totals[domain] = {}
        totals[domain]['score'] = score
        totals[domain]['raw'] = raw_score
        totals[domain]['risk'] = domain_risk(domain, raw_score * 100)
      end
      totals
    end

    def total_score(dimensions)
      dimensions.sum { |_key, value| value[:score] }
    end

    def total_raw_score(domain, score)
      factor = build_factor_klass::TRANSFORMATION_DOMAIN_FACTORS
      factor = factor[domain][form_type.to_sym]
      (score.to_f / factor).round(3)
    end

    def domain_risk(domain, score)
      if questionnaire == 'FRPI'
        klass = Results::Risks::AFrpiDomains
        klass.new(score, domain).call
      elsif questionnaire == 'FRPE'
        klass = Results::Risks::AFrpeDimensions
        klass.new(score, domain).call
      end
    end

    def build_factor_klass
      "Results::Factors::#{ questionnaire.capitalize }".constantize
    end
  end
end
