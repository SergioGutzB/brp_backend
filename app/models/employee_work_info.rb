# frozen_string_literal: true

class EmployeeWorkInfo < ApplicationRecord
  belongs_to :employee_profile
end
