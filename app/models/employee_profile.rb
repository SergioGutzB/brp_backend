# frozen_string_literal: true

class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  has_one :employee_personal_info
  has_one :employee_work_info

  accepts_nested_attributes_for :employee_personal_info, :employee_work_info
end
