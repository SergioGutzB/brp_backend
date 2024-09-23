# frozen_string_literal: true

module Results
  class CompanyRiskClassificationService
    RISK_LEVELS = %w[very_high high medium low very_low].freeze

    def initialize(company:, brp:, classification_type:, results:)
      @company = company
      @brp = brp
      @classification_type = classification_type # :factor, :domain, or :dimension
      @results = results
    end

    def call
      classify_by_form_type
    end

    private

    def classify_by_form_type
      classification = Hash.new { |hash, key| hash[key] = {} }

      @results.each do |form_type, totals|
        case @classification_type
        when :factor
          classify_by_factor(form_type, totals, classification)
        when :domain
          classify_by_domain(form_type, totals, classification)
        when :dimension
          classify_by_dimension(form_type, totals, classification)
        end
      end

      classification
    end

    def classify_by_factor(form_type, totals, classification)
      %w[frpi frpe ee].each do |factor|
        risk_level = totals.dig(factor, 'total_scores', 'risk')
        raw_score = totals.dig(factor, 'total_scores', 'raw')

        classification[form_type][factor] ||= initialize_risk_levels
        classification[form_type][factor][risk_level][:total] += 1
        classification[form_type][factor][risk_level][:raw_total] += raw_score.to_f
      end
    end

    def classify_by_domain(form_type, totals, classification)
      frpi_domains = totals.dig('frpi', 'domain_scores') || {}

      frpi_domains.each do |domain, domain_scores|
        classification[form_type]['frpi'] ||= {}
        classification[form_type]['frpi'][domain] ||= initialize_risk_levels

        risk_level = domain_scores['risk']
        raw_score = domain_scores['raw']

        classification[form_type]['frpi'][domain][risk_level][:total] += 1
        classification[form_type]['frpi'][domain][risk_level][:raw_total] += raw_score.to_f
      end
    end

    def classify_by_dimension(form_type, totals, classification)
      frpi_dimensions = totals.dig('frpi', 'dimension_scores') || {}

      frpi_dimensions.each do |domain, dimensions|
        classification[form_type]['frpi'] ||= {}
        classification[form_type]['frpi'][domain] ||= {}

        dimensions.each do |dimension, dimension_scores|
          classification[form_type]['frpi'][domain][dimension] ||= initialize_risk_levels

          risk_level = dimension_scores['risk']
          raw_score = dimension_scores['raw_score']

          classification[form_type]['frpi'][domain][dimension][risk_level][:total] += 1
          classification[form_type]['frpi'][domain][dimension][risk_level][:raw_total] += raw_score.to_f
        end
      end
    end

    def initialize_risk_levels
      RISK_LEVELS.each_with_object({}) do |level, hash|
        hash[level] = { total: 0, raw_total: 0.0 }
      end
    end
  end
end
