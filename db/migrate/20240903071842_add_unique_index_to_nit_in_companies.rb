class AddUniqueIndexToNitInCompanies < ActiveRecord::Migration[7.0]
  def change
    add_index :companies, :nit, unique: true
  end
end
