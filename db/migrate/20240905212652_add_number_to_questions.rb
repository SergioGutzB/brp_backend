class AddNumberToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :number, :integer
    add_index :questions, :number, unique: true
  end
end
