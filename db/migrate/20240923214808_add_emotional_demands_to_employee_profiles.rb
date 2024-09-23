class AddEmotionalDemandsToEmployeeProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :employee_profiles, :emotional_demands, :boolean
    add_column :employee_profiles, :relationship_with_collaborators, :boolean
  end
end
