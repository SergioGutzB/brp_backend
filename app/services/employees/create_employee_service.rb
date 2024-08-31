# frozen_string_literal: true

class CreateEmployeeService
  include SchemaValidatable

  def initialize(user_parameters, personal_parameters, work_parameters)
    @user_parameters = user_parameters
    @personal_parameters = personal_parameters
    @work_parameters = work_parameters
  end

  def execute!
    @user = User.new(user_parameters)
    @user.role = 'employee'

    if @user.save
      @employee = EmployeeProfile.new(user_id: @user.id, company_id: @work_parameters[:company_id])
      if @employee.save
        @employee.create_personal_info(personal_info_params)
        @employee.create_work_info(work_info_params)
        @employee
      else
        { error: 'Employee could not be created' }
      end
    else
      { error: 'User could not be created' }
    end
  end
end
