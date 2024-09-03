# frozen_string_literal: true

module Employees
  class UpdateService
    def initialize(id, personal_parameters, work_parameters)
      @id = id
      @personal_parameters = personal_parameters
      @work_parameters = work_parameters
    end

    def execute!
      ActiveRecord::Base.transaction do
        @employee = EmployeeProfile.find_by(id: @id)
        raise ActiveRecord::RecordNotFound unless @employee

        update_employee_personal_info
        update_employee_work_info
      end

      @employee
    rescue ActiveRecord::RecordInvalid => exception
      raise ErrorHandler::DetailedValidationError.new(exception.record.errors.messages,
        exception.record.class.name.underscore)
    rescue ActiveRecord::RecordNotFound
      raise ErrorHandler::DetailedValidationError.new({ employee_profile_id: ['not found'] }, 'employee_profile')
    end

    private

    def update_employee_personal_info
      personal_info = @employee.employee_personal_info
      raise ActiveRecord::RecordNotFound unless personal_info

      personal_info.assign_attributes(@personal_parameters)
      personal_info.save!
    end

    def update_employee_work_info
      work_info = @employee.employee_work_info
      raise ActiveRecord::RecordNotFound unless work_info

      work_info.assign_attributes(@work_parameters)
      work_info.save!
    end
  end
end
