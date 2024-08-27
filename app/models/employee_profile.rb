class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  has_one :personal_info, class_name: 'EmployeePersonalInfo'
  has_one :work_info, class_name: 'EmployeeWorkInfo'
end
