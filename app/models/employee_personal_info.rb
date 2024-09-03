# frozen_string_literal: true

class EmployeePersonalInfo < ApplicationRecord
  belongs_to :employee_profile

  validates :first_name, presence: { message: 'first_name_required' }
  validates :last_name, presence: { message: 'last_name_required' }
  validates :document_id, presence: { message: 'document_id_required' }
  validates :gender, presence: { message: 'gender_required' },
    inclusion: { in: %w[male female], message: 'invalid_gender' }
  validates :birthdate, presence: { message: 'birthdate_required' }
  validates :civil_status, presence: { message: 'civil_status_required' },
    inclusion: { in: %w[single married common_law divorced_or_separated widowed priest_or_nun],
                 message: 'invalid_civil_status' }
  validates :level_education, presence: { message: 'level_education_required' },
    inclusion: { in: %w[none incomplete_primary complete_primary incomplete_secondary complete_secondary
                        incomplete_technical_or_technological complete_technical_or_technological
                        incomplete_professional complete_professional military_or_police_career
                        incomplete_postgraduate complete_postgraduate],
                 message: 'invalid_level_education' }
  validates :socioeconomic_status, presence: { message: 'socioeconomic_status_required' },
    inclusion: { in: %w[1 2 3 4 5 6 farm i_dont_know], message: 'invalid_socioeconomic_status' }
  validates :living_place, presence: { message: 'living_place_required' },
    inclusion: { in: %w[own rented family], message: 'invalid_living_place' }
  validates :people_dependents, presence: { message: 'people_dependents_required' },
    numericality: { only_integer: true, message: 'people_dependents_must_be_integer' }
  validates :residence_state, presence: { message: 'residence_state_required' }
  validates :residence_city, presence: { message: 'residence_city_required' }

  validate :birthdate_is_valid_date

  private

  def birthdate_is_valid_date
    errors.add(:birthdate, 'invalid_birthdate') unless birthdate.is_a?(Date)
  rescue ArgumentError
    errors.add(:birthdate, 'invalid_birthdate')
  end
end
