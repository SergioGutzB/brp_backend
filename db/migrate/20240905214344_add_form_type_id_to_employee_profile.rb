class AddFormTypeIdToEmployeeProfile < ActiveRecord::Migration[7.0]
  def change
    add_reference :employee_profiles, :form_type, foreign_key: true, type: :uuid
  end
end
