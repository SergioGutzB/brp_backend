# frozen_string_literal: true

class EmployeePersonalInfo < ApplicationRecord
  belongs_to :employee_profile
end
