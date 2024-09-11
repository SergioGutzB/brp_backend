# frozen_string_literal: true

module Results
  class CalculateRawScore
    def initialize(employee_profile, questionnaire)
      @employee_profile = employee_profile
      @responses = Response.where(employee_profile: @employee_profile)
      @form_type = @employee_profile.form_type.name
      @questionnaire = questionnaire # FRPI | FRPE | EE
    end

    def call
      if @questionnaire == 'EE'
        calculate_totals_for_ee(build_klass::DOMAINS)
      else
        calculate_totals(build_klass::DOMAINS)
      end
    end

    private

    def build_klass
      "Results::Domains::#{ @questionnaire.capitalize }Domains".constantize
    end

    def calculate_totals(domains)
      result = {}

      domains.each do |key, value|
        if @questionnaire == 'FRPI'
          result[key] = calculate_for_domain(value)
        elsif @questionnaire == 'FRPE'
          result[key] = calculate_for_form_type(value)
        end
      end

      result
    end

    def calculate_totals_for_ee(domains)
      results = 0

      domains.each do |key, value|
        results += calculate_total_avegarage(value) * key.to_s.to_i
      end

      results
    end

    def calculate_for_domain(domain)
      totals = {}

      domain.each do |sub_key, forms|
        totals[sub_key] = calculate_for_form_type(forms[@form_type.to_sym])
      end

      totals
    end

    def calculate_for_form_type(question_numbers)
      return 0 unless question_numbers

      question_ids = Question.where(
        number: question_numbers,
        form_type: FormType.find_by(name: @form_type),
        questionnaire: Questionnaire.find_by(abbreviation: @questionnaire)
      ).pluck(:id)
      @responses.where(question_id: question_ids).sum(:total)
    end

    def calculate_total_avegarage(question_numbers)
      calculate_for_form_type(question_numbers).to_f / question_numbers.count
    end
  end
end
