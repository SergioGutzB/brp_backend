# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_executive

      def create
        company = Companies::CreateService.new(current_user, permitted_params)
        company.execute!

        render json: company, status: :created
      end

      def index
        @companies = current_user.executive_profile.companies
        render json: @companies
      end

      private

      def permitted_params
        params.require(:company).permit(:name, :nit)
      end
    end
  end
end
