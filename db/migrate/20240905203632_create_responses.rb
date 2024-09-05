class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses, id: :uuid do |t|
      t.references :brp, type: :uuid, null: false, foreign_key: true
      t.references :question, type: :uuid, null: false, foreign_key: true
      t.references :employee_profile, type: :uuid, null: false, foreign_key: true
      t.text :answer, null: false

      t.timestamps
    end
  end
end
