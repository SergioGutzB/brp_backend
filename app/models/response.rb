# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :brp
  belongs_to :question
  belongs_to :employee_profile

  ANSWER_OPTIONS = ['always', 'almost_always', 'sometimes', 'almost_never', 'never'].freeze

  validates :answer, presence: true, inclusion: { in: ANSWER_OPTIONS }
end
