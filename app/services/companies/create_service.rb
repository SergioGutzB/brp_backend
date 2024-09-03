# # frozen_string_literal: true

module Companies
  class CreateService
    def initialize(current_user, parameters)
      @parameters = parameters
      @current_user = current_user
    end

    def execute!
      create_company(@current_user, @parameters)
    end

    private

    def create_company(current_user, parameters)
      company = current_user.executive_profile.companies.new(parameters)
      company.save!
    end
  end
end
