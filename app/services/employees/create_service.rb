# frozen_string_literal: true

module Employees
  class CreateService
    include SchemaValidatable

    def initialize(user_parameters, personal_parameters, work_parameters)
      @user_parameters = user_parameters
      @personal_parameters = personal_parameters
      @work_parameters = work_parameters
    end

    def execute!
      @company = company(@work_parameters[:company_id])
      return company_error if @company.nil?

      create_employee
    end

    private

    def create_employee
      @user = User.new(@user_parameters)
      @user.role = 'employee'

      if @user.save
        @employee = EmployeeProfile.new(user_id: @user.id, company_id: @work_parameters[:company_id])
        if @employee.save
          @employee.create_personal_info(@personal_info_params)
          @employee.create_work_info(@work_info_params)
          @employee
        else
          { error: 'Employee could not be created' }
        end
      else
        { error: 'User could not be created' }
      end
    end

    def company(company_id)
      Company.find_by(id: company_id)
    end

    def company_error
      raise ExceptionError.new(I18n.t('errors.messages.field_not_found', field: :company_id), :company, :not_found)
    end
  end
end
