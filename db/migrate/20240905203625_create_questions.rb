class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :questionnaire, type: :uuid, null: false, foreign_key: true
      t.references :form_type, type: :uuid, null: false, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end
  end
end
