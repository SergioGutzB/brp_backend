class CreateAdminProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_profiles do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
