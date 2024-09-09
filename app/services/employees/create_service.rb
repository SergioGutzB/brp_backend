# frozen_string_literal: true

module Employees
  class CreateService
    include SchemaValidatable

    def initialize(user_parameters, personal_parameters, work_parameters, profile_parameters)
      @user_parameters = user_parameters
      @personal_parameters = personal_parameters
      @work_parameters = work_parameters
      @form_type_value = profile_parameters[:form_type]
    end

    def execute! # rubocop:disable Metrics/AbcSize
      ActiveRecord::Base.transaction do
        @company = find_company(@work_parameters[:company_id])

        @user = create_user
        raise_error unless @user.persisted?

        @employee = create_employee_profile
        raise_error unless @employee.persisted?

        create_employee_personal_info
        create_employee_work_info

        @employee
      end
    rescue ActiveRecord::RecordInvalid => exception
      raise DetailedValidationError.new(exception.record.errors.messages,
        exception.record.class.name.underscore)
    rescue StandardError => exception
      raise ExceptionError.new(exception.message, :employee, :unprocessable_entity)
    end

    private

    def find_company(company_id)
      Company.find_by!(id: company_id)
    end

    def company_error
      ExceptionError.new(I18n.t('errors.messages.field_not_found', field: :company_id), :company, :not_found)
    end

    def create_user
      user = User.new(@user_parameters)
      user.role = 'employee'
      user.save!
      user
    end

    def create_employee_profile
      EmployeeProfile.create(user_id: @user.id, company_id: @company.id, form_type:)
    end

    def form_type
      FormType.find_by(name: @form_type_value || 'A')
    end

    def create_employee_personal_info
      parameters = build_personal_parameters
      employee_personal_info = EmployeePersonalInfo.new(parameters)
      employee_personal_info.save!
    end

    def create_employee_work_info
      parameters = build_work_parameters
      employee_work_info = EmployeeWorkInfo.new(parameters)
      employee_work_info.save!
    end

    def build_work_parameters
      parameters = @work_parameters.except(:company_id)
      parameters.merge!(employee_profile_id: @employee.id)
    end

    def build_personal_parameters
      parameters = @personal_parameters
      parameters.merge!(employee_profile_id: @employee.id)
    end

    def valid_personal_parameters?(parameters)
      EmployeePersonalInfo.new(parameters).valid?
    end

    def valid_work_parameters?(parameters)
      EmployeeWorkInfo.new(parameters).valid?
    end

    def raise_error
      raise ExceptionError.new('Failed to create records', :employee, :unprocessable_entity)
    end
  end
end
