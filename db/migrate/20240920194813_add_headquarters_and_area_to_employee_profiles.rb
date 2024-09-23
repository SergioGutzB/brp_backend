class AddHeadquartersAndAreaToEmployeeProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_profiles, :headquarters, null: true, foreign_key: true, type: :uuid
    add_reference :employee_profiles, :area, null: true, foreign_key: true, type: :uuid
  end
end
