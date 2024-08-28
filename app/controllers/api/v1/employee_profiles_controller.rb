# frozen_string_literal: true

module Api
  module V1
    class EmployeeProfilesController < ApplicationController
      def show
        @employee = EmployeeProfile.find(params[:id])
        render json: {
          employee: @employee,
          personal_info: @employee.personal_info,
          work_info: @employee.work_info
        }
      end

      def create
        @employee = EmployeeProfile.new(employee_params)
        if @employee.save
          @employee.create_personal_info(personal_info_params)
          @employee.create_work_info(work_info_params)
          render json: @employee, status: :created
        else
          render json: @employee.errors, status: :unprocessable_entity
        end
      end

      private

      def employee_params
        params.require(:employee).permit(:user_id, :first_name, :last_name)
      end

      def personal_info_params
        params.require(:personal_info).permit(
          :marital_status,
          :nationality,
          :birth_date,
          :identification_type,
          :identification_number,
          :blood_type,
          :address,
          :phone_number,
          :emergency_contact_name,
          :emergency_contact_phone
        )
      end

      def work_info_params
        params.require(:work_info).permit(:department, :position, :hire_date, :salary, :contract_type, :work_schedule,
          :supervisor_name, :employee_id, :bank_account_number, :bank_name)
      end
    end
  end
end
