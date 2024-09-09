# frozen_string_literal: true

ANSWER_OPTIONS = ['always', 'almost_always', 'sometimes', 'almost_never', 'never'].freeze

namespace :responses do # rubocop:disable Metrics/BlockLength
  desc 'Crear responses para cada pregunta según el FormType del EmployeeProfile'

  task create_for_employee_profile: :environment do # rubocop:disable Metrics/BlockLength
    employee_profile_id = ENV['employee_profile_id']
    brp_id = ENV['brp_id']

    if employee_profile_id.nil? || brp_id.nil?
      puts 'Error: Debes proporcionar el employee_profile_id y brp_id como parámetros.'
      puts 'Ejemplo: rake responses:create_for_employee_profile employee_profile_id=<id> brp_id=<id>'
      exit
    end

    employee_profile = EmployeeProfile.find_by(id: employee_profile_id)
    if employee_profile.nil?
      puts "Error: No se encontró el EmployeeProfile con ID #{ employee_profile_id }"
      exit
    end

    form_type = employee_profile.form_type
    if form_type.nil?
      puts 'Error: El EmployeeProfile no tiene un FormType asignado.'
      exit
    end

    question_ids = Question.where(form_type_id: form_type.id).pluck(:id)

    if question_ids.empty?
      puts "Error: No se encontraron preguntas para el FormType #{ form_type.id }"
      exit
    end

    puts "Preguntas encontradas para el FormType #{ form_type.id }: #{ question_ids.inspect }"

    existing_responses = Response.where(employee_profile_id:).pluck(:question_id)

    unanswered_questions = question_ids - existing_responses

    if unanswered_questions.empty?
      puts 'No hay preguntas sin responder para este EmployeeProfile.'
      exit
    end

    new_responses = []
    unanswered_questions.each do |question_id|
      next if question_id.nil?

      answer = ANSWER_OPTIONS.sample

      new_responses << {
        employee_profile_id:,
        question_id:,
        brp_id:,
        answer:,
        created_at: Time.now,
        updated_at: Time.now
      }
    end

    if new_responses.any?
      Response.insert_all(new_responses)
      puts "Respuestas creadas para #{ new_responses.size } preguntas."
    else
      puts 'No hay preguntas nuevas para crear respuestas.'
    end

    puts 'Proceso completado.'
  end
end
