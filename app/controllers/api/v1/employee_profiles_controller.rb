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
        service = Employees::CreateService.new(user_params, personal_info_params, work_info_params,
          employee_profile_params)
        employee = service.execute!
        render json: employee, status: :created
      end

      def update
        service = Employees::UpdateService.new(params[:id], personal_info_params, work_info_params)
        employee = service.execute!
        render json: employee, status: :ok
      end

      def response_percentages
        service = Employees::CalculateResponsePercentages.new(params[:id])
        percentages = service.execute!

        render json: percentages, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def employee_profile_params
        params.require(:employee_profile).permit(:form_type)
      end

      def personal_info_params
        EmployeePermittedParams.personal_info_params(params.require(:personal_info))
      end

      def work_info_params
        EmployeePermittedParams.work_info_params(params.require(:work_info))
      end
    end
  end
end
