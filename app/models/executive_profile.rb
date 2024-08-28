# frozen_string_literal: true

class ExecutiveProfile < ApplicationRecord
  belongs_to :user

  has_many :companies
  has_many :employees, through: :companies
end
