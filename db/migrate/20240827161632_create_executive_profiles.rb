class CreateExecutiveProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :executive_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.string :nit
      t.string :professional_card
      t.string :phone

      t.timestamps
    end
  end
end
