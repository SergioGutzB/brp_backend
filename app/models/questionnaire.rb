# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  validates :name, presence: true
  validates :abbreviation, presence: true, uniqueness: true
end
