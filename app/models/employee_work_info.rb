# frozen_string_literal: true

class EmployeeWorkInfo < ApplicationRecord
  belongs_to :employee_profile

  validates :work_city, presence: { message: 'work_city_required' }
  validates :work_state, presence: { message: 'work_state_required' }
  validates :seniority_company, presence: { message: 'seniority_company_required' },
    inclusion: { in: %w[less_than_a_year more_than_a_year], message: 'invalid_seniority_company' }
  validates :position_held, presence: { message: 'position_held_required' }
  validates :seniority_office, presence: { message: 'seniority_office_required' },
    inclusion: { in: %w[less_than_1_year 1_to_2 3_to_5 6_to_10 11_or_more_years],
                 message: 'invalid_seniority_office' }
  validates :work_area, presence: { message: 'work_area_required' },
    inclusion: { in: %w[production administrative], message: 'invalid_work_area' }
  validates :contract_type, presence: { message: 'contract_type_required' },
    inclusion: { in: %w[temporary_less_than_1_year temporary_1_year_or_more indefinite_term
                        cooperative service_provision i_dont_know],
                 message: 'invalid_contract_type' }
  validates :working_hours_per_day, presence: { message: 'working_hours_per_day_required' },
    numericality: { message: 'working_hours_per_day_must_be_number' }
  validates :salary_type, presence: { message: 'salary_type_required' },
    inclusion: { in: %w[fixed fixed_and_variable variable], message: 'invalid_salary_type' }
  validates :occupation, presence: { message: 'occupation_required' }
end
