class RemoveTextFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :text, :string
  end
end
