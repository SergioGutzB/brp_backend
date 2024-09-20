class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results, id: :uuid do |t|
      t.jsonb :totals, default: {}
      t.integer :status, default: 0
      t.jsonb :progress, default: { frpi: 0, frpe: 0, ee: 0 }
      t.references :employee_profile, null: false, foreign_key: true, type: :uuid
      t.references :brp, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
