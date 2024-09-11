# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :brp
  belongs_to :question
  belongs_to :employee_profile

  has_one :questionnaire, through: :question
  has_one :form_type, through: :employee_profile

  after_save :calculate_total
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

    total_score = calculate_for_question(form_type, questionnaire_name, question_number, answer)
    update_column(:total, total_score)
  end

  def form_type
    employee_profile.form_type.name
  end
end
