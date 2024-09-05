# frozen_string_literal: true

namespace :db do # rubocop:disable Metrics/BlockLength
  desc 'Generate questions for each questionnaire based on form type'
  task generate_questions: :environment do # rubocop:disable Metrics/BlockLength
    # Define the number of questions for each questionnaire based on form type
    questions_count = {
      'A' => {
        'FRPI' => 123,
        'FRPE' => 31,
        'EE' => 31
      },
      'B' => {
        'FRPI' => 97,
        'FRPE' => 31,
        'EE' => 31
      }
    }

    # Loop through each form type
    questions_count.each do |form_type, questionnaires|
      form_type = FormType.find_by(name: form_type)

      if form_type.nil?
        puts "Form type '#{ form_type }' not found!"
        next
      end

      questionnaires.each do |abbreviation, count|
        # Find the questionnaire by abbreviation and form type
        questionnaire = Questionnaire.find_by(abbreviation:)

        if questionnaire.nil?
          puts "Questionnaire with abbreviation '#{ abbreviation }' not found!"
          next
        end

        # Generate questions for the questionnaire
        (1..count).each do |number|
          puts "creating question #{ number } for questionnaire '#{ abbreviation }'"
          question = Question.find_or_initialize_by(questionnaire:, number:, form_type:)
          if question.new_record?
            question.save!
            puts "Created question #{ number } for questionnaire '#{ abbreviation }'"
          end
        end
      end
    end

    puts 'Questions generated successfully!'
  end
end
