# frozen_string_literal: true

class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :form_type
  belongs_to :headquarters, optional: true
  belongs_to :area, optional: true

  has_one :employee_personal_info
  has_one :employee_work_info
  has_many :responses
  has_many :results

  accepts_nested_attributes_for :employee_personal_info, :employee_work_info

  validates :form_type, presence: true, unless: -> { id.present? && form_type_id.nil? }

  def responses_count_by_questionnaire
    questionnaire_types = %w[FRPI FRPE EE]

    counts = Hash.new(0)

    puts "form_type_id: #{ form_type_id } (#{ form_type.name })"

    questionnaire_types.each do |type|
      questionnaire = Questionnaire.find_by(abbreviation: type)
      next unless questionnaire

      counts[type] = responses.joins(:question)
        .where(questions: { questionnaire_id: questionnaire.id })
        .where(questions: { form_type_id: })
        .count
    end

    counts
  end
end
