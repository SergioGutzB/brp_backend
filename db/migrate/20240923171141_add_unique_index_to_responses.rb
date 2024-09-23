class AddUniqueIndexToResponses < ActiveRecord::Migration[7.0]
  def change
    add_index :responses, %i[question_id employee_profile_id], unique: true
  end
end
