class AddTotalToResponse < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :total, :integer
  end
end
