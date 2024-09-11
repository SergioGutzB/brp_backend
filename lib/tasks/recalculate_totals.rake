# frozen_string_literal: true

namespace :responses do
  desc 'Recalcula el total de los responses que tienen el total en null'
  task recalculate_totals: :environment do
    responses = Response.where(id: '6a9a7fb9-df81-49e5-a392-73913ddbb835')

    responses.find_each do |response|
      form_type = response.employee_profile.form_type.name
      question_number = response.question.number
      questionnaire_name = response.question.questionnaire.abbreviation

      total = Responses::CalculateResponseTotalService.new(form_type, questionnaire_name, question_number,
        response.answer).call
      response.update_column(:total, total)
    end

    puts "#{ responses.count } responses recalculated."
  end
end
