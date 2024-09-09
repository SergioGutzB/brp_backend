# frozen_string_literal: true

class Brp < ApplicationRecord
  belongs_to :company

  validate :year_cannot_be_in_the_future

  def year
    self[:year]&.year
  end

  def year=(year)
    self[:year] = Date.new(year.to_i, 1, 1)
  end

  private

  def year_cannot_be_in_the_future
    if year.present? && year > Date.current.year
      errors.add(:year, "can't be greater than the current year")
    end
  end
end
