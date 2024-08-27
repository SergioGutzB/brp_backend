class CreateEmployeeWorkInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_work_infos do |t|
      t.references :employee_profile, null: false, foreign_key: true

      t.string :work_city
      t.string :work_state
      t.string :seniority_company
      t.string :seniority_office

      t.string :position_held
      t.string :work_area
      t.string :contract_type
      t.string :working_hours_per_day
      t.string :salary_type
      t.string :ocupation


      t.timestamps
    end
  end
end
