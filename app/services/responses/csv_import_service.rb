# frozen_string_literal: true

module Responses
  class CsvImportService
    def initialize(file, parameters)
      @file = file
      @employee_profile_id = parameters[:employee_profile_id]
      @brp_id = parameters[:brp_id]
    end

    def call
      new_responses = []

      csv_data.each do |row|
        question = question(row)
        answer = answer(row)

        new_responses << {
          question_id: question.id,
          answer:,
          employee_profile_id:,
          brp_id:,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      create_responses(new_responses)
    end

    private

    attr_reader :employee_profile_id, :brp_id

    def create_responses(new_responses)
      if new_responses.any?
        begin
          Response.transaction do
            Response.insert_all(new_responses)
          end
        rescue ActiveRecord::RecordNotUnique => exception
          return raise ExceptionError.new(
            exception.message,
            :response,
            :unprocessable_entity
          )
        end
      end

      { success: true, data: new_responses }
    end

    def employee_profile
      @employee_profile ||= EmployeeProfile.find(employee_profile_id)
    end

    def answer(row)
      answer = determine_answer(row)
      if answer.nil?
        raise ExceptionError.new(
          "No se pudo determinar una respuesta válida para la pregunta #{ question_number }",
          :answer,
          :unprocessable_entity
        )
      end

      answer
    end

    def questionnaire(abbreviation)
      questionnaire = Questionnaire.find_by(abbreviation:)
      if questionnaire.nil?
        raise ExceptionError.new(
          "No se encontró un cuestionario con la abreviatura #{ questionnaire_abbreviation }",
          :questionnaire,
          :unprocessable_entity
        )
      end

      questionnaire
    end

    def question(row)
      number = row['item']
      questionnaire_abbreviation = row['questionnaire']

      questionnaire = questionnaire(questionnaire_abbreviation)
      questionnaire_id = questionnaire.id

      @question = Question.find_by(number:, questionnaire_id:, form_type:)

      if @question.nil?
        raise ExceptionError.new(
          "No se encontró una pregunta con el número #{ number } en el cuestionario #{ questionnaire_id }",
          :question,
          :unprocessable_entity
        )
      end

      @question
    end

    def csv_data
      csv_data ||= CSV.read(@file.path, headers: true)
      if csv_data.headers.blank?
        raise ExceptionError.new('El archivo CSV no tiene encabezados', :header,
          :unprocessable_entity)
      end

      csv_data
    end

    def form_type
      @form_type ||= employee_profile&.form_type
    end

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
