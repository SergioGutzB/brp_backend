# frozen_string_literal: true

class FormType < ApplicationRecord
  has_many :employee_profiles

  validates :name, presence: true, uniqueness: true, inclusion: { in: %w[A B] }
end
