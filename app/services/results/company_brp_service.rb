# frozen_string_literal: true

module Results
  class CompanyBrpService
    def initialize(company_id:, brp_id:, headquarters_id: nil, area_id: nil)
      @company_id = company_id
      @brp_id = brp_id
      @headquarters_id = headquarters_id
      @area_id = area_id
    end

    def call
      results = Result
        .joins(employee_profile: %i[company form_type])
        .where(companies: { id: company_id }, brp_id:)

      results = filter_by_headquarters(results) if headquarters_id
      results = filter_by_area(results) if area_id

      classify_by_form_type(results)
    end

    private

    attr_reader :company_id, :brp_id, :headquarters_id, :area_id

    def filter_by_headquarters(results)
      results.joins(employee_profile: :headquarters).where(headquarters: { id: headquarters_id })
    end

    def filter_by_area(results)
      results.joins(employee_profile: :area).where(areas: { id: area_id })
    end

    def classify_by_form_type(results)
      results.group('form_types.name').pluck('form_types.name', 'ARRAY_AGG(totals)')
    end
  end
end
