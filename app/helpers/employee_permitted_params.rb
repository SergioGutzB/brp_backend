# frozen_string_literal: true

module EmployeePermittedParams
  PERMITTED_PERSOLAN_INFO_PARAMS = %i[
    first_name
    last_name
    document_id
    gender
    birthdate
    civil_status
    level_education
    socioeconomic_status
    living_place
    people_dependents
    residence_state
    residence_city
  ].freeze

  PERMITTED_WORK_INFO_PARAMS = %i[
    work_city
    work_state
    seniority_company
    seniority_office
    position_held
    work_area
    contract_type
    working_hours_per_day
    salary_type
    ocupation
    company_id
  ].freeze

  class << self
    def personal_info_params(params)
      JSON.parse(params.permit(PERMITTED_PERSOLAN_INFO_PARAMS).to_json, symbolize_names: true)
    end

    def work_info_params(params)
      JSON.parse(params.permit(PERMITTED_WORK_INFO_PARAMS).to_json, symbolize_names: true)
    end
  end
end
