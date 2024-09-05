class RemoveUniqueIndexFromQuestionsNumber < ActiveRecord::Migration[7.0]
  def change
    remove_index :questions, :number if index_exists?(:questions, :number)
  end
end
