class AddNotNullConstraintToFormTypeInEmployeeProfiles < ActiveRecord::Migration[7.0]
  def change
    change_column_null :employee_profiles, :form_type_id, false
  end
end
