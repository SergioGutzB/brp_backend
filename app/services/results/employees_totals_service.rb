# frozen_string_literal: true

module Results
  class EmployeesTotalsService
    def initialize(employee_id)
      @employee_id = employee_id
    end

    def call
      @employee = EmployeeProfile.find(@employee_id)
      # TODO: translate error message
      raise ExceptionError.new('Employee not found', :employee, :not_found) if @employee.nil?

      totals
    end

    private

    attr_reader :employee

    def form_type
      employee.form_type.name
    end

    def totals
      {
        frpi: frpi_totals,
        frpe: frpe_totals,
        ee: ee_totals
      }
    end

    def frpi_totals
      dimension_scores = Results::CalculateDimensionScores.new(employee, 'FRPI').call
      domain_scores = Results::CalculateDomainScores.new(dimension_scores, form_type, 'FRPI').call
      total_scores = Results::CalculateFactorTotals.new('FRPI', form_type, domain_scores).call

      {
          dimension_scores:,
          domain_scores:,
          total_scores:
      }
    end

    def frpe_totals
      dimension_scores = Results::CalculateDimensionScores.new(employee, 'FRPE').call
      total_scores = Results::CalculateDomainScores.new(dimension_scores, form_type, 'FRPE').call

      {
          dimension_scores:,
          total_scores:
      }
    end

    def ee_totals
      total_scores = Results::CalculateDimensionScores.new(employee, 'EE').call

      {
          total_scores:
      }
    end
  end
end
