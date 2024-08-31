# frozen_string_literal: true

class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  has_one :personal_info, class_name: 'EmployeePersonalInfo'
  has_one :work_info, class_name: 'EmployeeWorkInfo'

  accepts_nested_attributes_for :work_info, :personal_info
end
