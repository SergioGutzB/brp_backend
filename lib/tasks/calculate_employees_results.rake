# frozen_string_literal: true

namespace :results do
  desc 'Calculate employees results'
  task calculate_employees_results: :environment do
    company_id = ENV['COMPANY_ID'] # Pasa el company_id como parámetro
    brp_id = ENV['BRP_ID'] # Pasa el brp_id como parámetro

    company = Company.find(company_id)

    company.employee_profiles.each do |employee_profile|
      # Calcula el porcentaje de preguntas respondidas
      percentages = Employees::ResponsePercentageCalculatorService.new(employee_profile.id).execute!

      # Si el total de respuestas es 100%, calcula y guarda los resultados
      if percentages[:total] >= 100
        calculate_and_save_totals(employee_profile, brp_id, percentages)
      else
        puts "Employee #{ employee_profile.id } (#{ employee_profile.employee_personal_info.first_name }) has not completed all questionnaires.,
          form_type #{ employee_profile.form_type.name } (#{ employee_profile.form_type.id })"
      end
    rescue StandardError => exception
      puts "Error processing employee #{ employee_profile.id }: #{ exception.message }"
    end
  end

  def calculate_and_save_totals(employee_profile, brp_id, percentages)
    totals = Results::EmployeesTotalsService.new(employee_profile.id).call
    progress = percentages.except(:total).transform_keys { |key| key.to_s.downcase.to_sym }

    result = Result.find_or_initialize_by(employee_profile:, brp_id:)
    result.update(totals:, status: 'completed', progress:)

    puts "Results saved for employee #{ employee_profile.id } form type #{ employee_profile.form_type.name }"
  end
end
