class Headquarter < ApplicationRecord
  belongs_to :company
  has_many :employee_profiles

  validates :name, presence: true
end
