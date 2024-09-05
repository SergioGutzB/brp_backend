class AddAbbreviationToQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    add_column :questionnaires, :abbreviation, :string
  end
end
