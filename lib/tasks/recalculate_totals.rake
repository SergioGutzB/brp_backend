# frozen_string_literal: true

namespace :responses do
  desc 'Recalcula el total de los responses que tienen el total en null'
  task recalculate_totals: :environment do
    # responses = Response.where(total: nil)
    responses = Response.all

    responses.find_each do |response|
      form_type = response.employee_profile.form_type.name
      question_number = response.question.number
      questionnaire_name = response.question.questionnaire.abbreviation
      negative_lrst_dc = response.employee_profile.emotional_demands
      negative_lrst_rc = response.employee_profile.relationship_with_collaborators

      total = Responses::CalculateResponseTotalService.new(
        form_type:,
        questionnaire_name:,
        question_number:,
        answer: response.answer,
        negative_lrst_dc:,
        negative_lrst_rc:
      ).call
      response.update_column(:total, total)
    end

    puts "#{ responses.count } responses recalculated."
  end
end
