# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :brp
  belongs_to :question
  belongs_to :employee_profile

  has_one :questionnaire, through: :question
  has_one :form_type, through: :employee_profile

  after_save :calculate_total
  after_save :check_completion_and_update_results
  after_save :validate_negative_response

  ANSWER_OPTIONS = ['always', 'almost_always', 'sometimes', 'almost_never', 'never'].freeze

  validates :answer, presence: true, inclusion: { in: ANSWER_OPTIONS }
  validates_presence_of :question, :brp, :employee_profile
  validates :question_id,
    uniqueness: { scope: :employee_profile_id }

  validate :validate_question_for_employee_form_type

  private

  def validate_question_for_employee_form_type
    if question.form_type_id != employee_profile.form_type_id
      errors.add(:question_id, I18n.t('errors.messages.wrong_form_type'))
    end
  end

  def calculate_total
    question_number = question.number
    questionnaire_name = question.questionnaire.abbreviation

    total_score = Responses::CalculateResponseTotalService.new(
      form_type:,
      questionnaire_name:,
      question_number:,
      answer:,
      negative_lrst_dc: employee_profile.emotional_demans,
      negative_lrst_rc: employee_profile.relationship_with_collaborators
    ).call

    update_column(:total, total_score)
  end

  validate

  def form_type
    employee_profile.form_type.name
  end

  def check_completion_and_update_results
    if all_questions_answered?
      calculate_and_save_totals
    else
      update_completion_percentage
    end
  end

  def percentages
    @percentages ||= Employees::ResponsePercentageCalculatorService.new(employee_profile.id).execute!
  end

  def all_questions_answered?
    percentages[:total] == 100
  end

  def calculate_and_save_totals
    totals = Results::EmployeesTotalsService.new(employee_profile.id).call
    progress = percentages.except(:total).transform_keys { |key| key.to_s.downcase.to_sym }

    result = Result.find_or_initialize_by(employee_profile:, brp:)
    result.update(totals:, status: 'completed', progress:)
  end

  def update_completion_percentage
    progress = percentages.except(:total).transform_keys { |key| key.to_s.downcase.to_sym }

    result = Result.find_or_initialize_by(employee_profile:, brp:)
    result.update(progress:, status: 'in_progress')
  end
end
