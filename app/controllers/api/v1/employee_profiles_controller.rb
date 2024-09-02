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
        service = Employees::CreateEmployeeService.new(user_params, personal_info_params, work_info_params)
        service.execute!
        render json: service, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
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
