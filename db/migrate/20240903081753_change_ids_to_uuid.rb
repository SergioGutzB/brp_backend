class ChangeIdsToUuid < ActiveRecord::Migration[7.0]
  def up
    # Disable foreign key checks
    execute 'SET CONSTRAINTS ALL DEFERRED'

    # Remove foreign key constraints
    remove_foreign_keys

    # Change id columns to uuid
    change_id_to_uuid(:admin_profiles)
    change_id_to_uuid(:employee_personal_infos)
    change_id_to_uuid(:employee_profiles)
    change_id_to_uuid(:employee_work_infos)
    change_id_to_uuid(:executive_profiles)
    change_id_to_uuid(:jwt_denylists)
    change_id_to_uuid(:users)

    # Change foreign key columns to uuid
    change_column_to_uuid(:admin_profiles, :user_id)
    change_column_to_uuid(:companies, :executive_profile_id)
    change_column_to_uuid(:employee_personal_infos, :employee_profile_id)
    change_column_to_uuid(:employee_profiles, :user_id)
    change_column_to_uuid(:employee_work_infos, :employee_profile_id)
    change_column_to_uuid(:executive_profiles, :user_id)

    # Recreate foreign key constraints
    add_foreign_keys

    # Re-enable foreign key checks
    execute 'SET CONSTRAINTS ALL IMMEDIATE'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def remove_foreign_keys
    execute 'ALTER TABLE admin_profiles DROP CONSTRAINT IF EXISTS fk_rails_bdfe0f01ea'
    execute 'ALTER TABLE employee_profiles DROP CONSTRAINT IF EXISTS fk_rails_f69b2eb197'
    execute 'ALTER TABLE executive_profiles DROP CONSTRAINT IF EXISTS fk_rails_447fa5dfde'
    execute 'ALTER TABLE companies DROP CONSTRAINT IF EXISTS fk_rails_801308e536'
    execute 'ALTER TABLE employee_personal_infos DROP CONSTRAINT IF EXISTS fk_rails_ff1975120b'
    execute 'ALTER TABLE employee_work_infos DROP CONSTRAINT IF EXISTS fk_rails_c1b8015db8'
  end

  def add_foreign_keys
    execute 'ALTER TABLE admin_profiles ADD CONSTRAINT fk_rails_bdfe0f01ea FOREIGN KEY (user_id) REFERENCES users(id)'
    execute 'ALTER TABLE employee_profiles ADD CONSTRAINT fk_rails_f69b2eb197 FOREIGN KEY (user_id) REFERENCES users(id)'
    execute 'ALTER TABLE executive_profiles ADD CONSTRAINT fk_rails_447fa5dfde FOREIGN KEY (user_id) REFERENCES users(id)'
    execute 'ALTER TABLE companies ADD CONSTRAINT fk_rails_801308e536 FOREIGN KEY (executive_profile_id) REFERENCES executive_profiles(id)'
    execute 'ALTER TABLE employee_personal_infos ADD CONSTRAINT fk_rails_ff1975120b FOREIGN KEY (employee_profile_id) REFERENCES employee_profiles(id)'
    execute 'ALTER TABLE employee_work_infos ADD CONSTRAINT fk_rails_c1b8015db8 FOREIGN KEY (employee_profile_id) REFERENCES employee_profiles(id)'
  end

  def change_id_to_uuid(table_name)
    # Remove the default value and primary key constraint
    execute "ALTER TABLE #{ table_name } DROP CONSTRAINT IF EXISTS #{ table_name }_pkey"
    execute "ALTER TABLE #{ table_name } ALTER COLUMN id DROP DEFAULT"

    # Change the column type to uuid
    change_column table_name, :id, :uuid, using: 'gen_random_uuid()'

    # Add primary key constraint back
    execute "ALTER TABLE #{ table_name } ADD PRIMARY KEY (id)"

    # Set up id to be auto-generated for new records
    execute "ALTER TABLE #{ table_name } ALTER COLUMN id SET DEFAULT gen_random_uuid()"
  end

  def change_column_to_uuid(table_name, column_name)
    change_column table_name, column_name, :uuid, using: 'gen_random_uuid()'
  end
end
