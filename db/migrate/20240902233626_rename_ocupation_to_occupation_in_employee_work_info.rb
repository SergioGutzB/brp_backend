class RenameOcupationToOccupationInEmployeeWorkInfo < ActiveRecord::Migration[7.0]
  def change
    rename_column :employee_work_infos, :ocupation, :occupation
  end
end
