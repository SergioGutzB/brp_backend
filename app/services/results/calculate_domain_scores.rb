# frozen_string_literal: true

module Results
  class CalculateDomainScores
    def initialize(dimension_scores, form_type, questionnaire)
      @dimension_scores = dimension_scores
      @form_type = form_type
      @questionnaire = questionnaire
    end

    def call
      case questionnaire
      when 'FRPE' then frpe_totals
      when 'FRPI' then frpi_totals
      end
    end

    private

    attr_reader :dimension_scores, :form_type, :questionnaire

    def frpe_totals
      score = total_score(dimension_scores)
      raw_score = total_frpe_raw_score(score)

      totals = {}
      totals[:score] = score
      totals[:raw] = raw_score
      totals[:risk] = domain_risk(raw_score * 100)

      totals
    end

    def frpi_totals
      totals = {}
      dimension_scores.each do |domain, dimensions|
        score = total_score(dimensions)
        raw_score = total_frpi_raw_score(domain, score)
        totals[domain] = {}
        totals[domain][:score] = score
        totals[domain][:raw] = raw_score
        totals[domain][:risk] = domain_risk(domain, raw_score * 100)
      end
      totals
    end

    def total_score(dimensions)
      dimensions.sum { |_key, value| value[:score] }
    end

    def total_frpi_raw_score(domain, score)
      factor = build_factor_klass::TRANSFORMATION_DOMAIN_FACTORS
      factor = factor[domain][form_type.to_sym]
      (score.to_f / factor).round(3)
    end

    def total_frpe_raw_score(score)
      factor = build_factor_klass::TRANSFORMATION_TOTAL_FACTORS
      factor = factor[form_type.to_sym]
      (score.to_f / factor).round(3)
    end

    def domain_risk(score, domain = nil)
      klass = Results::Risks::AFrpeDomains
      case questionnaire
      when 'FRPI' && domain
        klass.new(score, domain).call
      when 'FRPE'
        klass.new(score).call
      end
    end

    def build_factor_klass
      "Results::Factors::#{ questionnaire.capitalize }".constantize
    end
  end
end
