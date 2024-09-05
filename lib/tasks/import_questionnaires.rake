# frozen_string_literal: true

namespace :db do
  desc 'Import questionnaires from YAML files'
  task import_questionnaires: :environment do
    # Load the questionnaires from YAML file
    questionnaires_file = Rails.root.join('db', 'seeds', 'questionnaires.yml')

    # Check if the file exists
    unless File.exist?(questionnaires_file)
      puts "YAML file not found: #{ questionnaires_file }"
      next
    end

    # Parse the YAML file
    questionnaires_data = YAML.load_file(questionnaires_file)

    # Iterate over each questionnaire and create or update records
    questionnaires_data.each do |questionnaire_attrs|
      questionnaire = Questionnaire.find_or_initialize_by(name: questionnaire_attrs['name'],
        abbreviation: questionnaire_attrs['abbreviation'])
      questionnaire.update!(questionnaire_attrs)
    end

    puts 'Questionnaires imported successfully!'
  end
end
