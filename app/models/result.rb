# frozen_string_literal: true

class Result < ApplicationRecord
  belongs_to :employee_profile
  belongs_to :brp

  enum status: { initial: 0, in_progress: 1, completed: 2 }
end
