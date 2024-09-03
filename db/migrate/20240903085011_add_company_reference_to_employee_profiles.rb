class AddCompanyReferenceToEmployeeProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_profiles, :company, type: :uuid, foreign_key: true
  end
end
