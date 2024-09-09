# frozen_string_literal: true

module Responses
  class CsvImportService
    def initialize(file, parameters)
      @file = file
      @employee_profile_id = parameters[:employee_profile_id]
      @brp_id = parameters[:brp_id]
    end

    def call # rubocop:disable Metrics/MethodLength,Metrics/AbcSize,Metrics/CyclomaticComplexity
      csv_data = CSV.read(@file.path, headers: true)
      return { success: false, error: 'El archivo CSV no tiene encabezados' } if csv_data.headers.blank?

      new_responses = []

      csv_data.each do |row| # rubocop:disable Metrics/BlockLength
        question_number = row['item']
        questionnaire_abbreviation = row['questionnaire']

        questionnaire = Questionnaire.find_by(abbreviation: questionnaire_abbreviation)
        if questionnaire.nil?
          return { success: false,
                   error: "No se encontró un cuestionario con la abreviatura #{ questionnaire_abbreviation }" }
        end

        questionnaire_id = questionnaire.id

        question = Question.find_by(number: question_number, questionnaire_id:)
        if question.nil?
          return {
            success: false,
            error: "No se encontró una pregunta con el número #{ question_number } en el cuestionario #{ questionnaire_id }"
          }
        end

        answer = determine_answer(row)
        if answer.nil?
          return { success: false,
                   error: "No se pudo determinar una respuesta válida para la pregunta #{ question_number }" }
        end

        new_responses << {
          question_id: question.id,
          answer:,
          employee_profile_id: @employee_profile_id,
          brp_id: @brp_id,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      if new_responses.any?
        Response.insert_all(new_responses)
      end

      { success: true, data: new_responses }
    rescue StandardError => exception
      { success: false, error: exception.message }
    end

    private

    def determine_answer(row)
      answer_columns = {
        'always' => row['always'],
        'almost_always' => row['almost_always'],
        'sometimes' => row['sometimes'],
        'almost_never' => row['almost_never'],
        'never' => row['never']
      }

      valid_column = answer_columns.find { |_, value| value.present? && value.to_f.positive? }

      valid_column&.first
    end
  end
end
