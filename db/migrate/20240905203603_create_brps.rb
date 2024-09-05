class CreateBrps < ActiveRecord::Migration[7.0]
  def change
    create_table :brps, id: :uuid do |t|
      t.references :company, type: :uuid, null: false, foreign_key: true
      t.date :year, null: false

      t.timestamps
    end
  end
end
