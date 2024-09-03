class ChangeCompaniesIdToUuid < ActiveRecord::Migration[7.0]
  def up
    # Añade una nueva columna temporal `uuid` para guardar los UUID generados
    add_column :companies, :uuid, :uuid, default: 'gen_random_uuid()'

    # Copia los valores de la columna `id` a la nueva columna `uuid`
    execute 'UPDATE companies SET uuid = gen_random_uuid()'

    # Cambia las tablas que tienen `company_id` como referencia
    # change_column :other_table, :company_id, :uuid

    # Elimina la columna `id` y renombra `uuid` a `id`
    remove_column :companies, :id
    rename_column :companies, :uuid, :id

    # Establece `id` como la nueva clave primaria
    execute 'ALTER TABLE companies ADD PRIMARY KEY (id)'
  end

  def down
    # Si necesitas revertir esta migración, cambia el tipo de `id` de vuelta a integer
    raise ActiveRecord::IrreversibleMigration
  end
end
