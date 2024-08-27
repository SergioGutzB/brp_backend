class Company < ApplicationRecord
  belongs_to :executive_profile
  has_many :employee_profiles
end
