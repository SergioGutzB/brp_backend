class AddExecutiveProfileToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_reference :companies, :executive_profiles, null: false, foreign_key: true
  end
end
