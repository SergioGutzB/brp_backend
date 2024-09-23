# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :executive_profile

  has_many :employee_profiles
  has_many :brps
  has_many :headquarters
  has_many :areas
end
