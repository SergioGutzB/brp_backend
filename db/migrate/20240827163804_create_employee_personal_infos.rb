class CreateEmployeePersonalInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_personal_infos do |t|
      t.references :employee_profile, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :document_id
      t.string :gender
      t.date :birthdate
      t.string :civil_status
      t.string :level_education
      t.string :socioeconomic_status
      t.string :living_place
      t.string :people_dependents
      t.string :residence_state
      t.string :residence_city

      t.timestamps
    end
  end
end
