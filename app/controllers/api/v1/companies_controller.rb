# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_executive

      def create
        @company = current_user.executive_profile.companies.new(company_params)
        if @company.save
          render json: @company, status: :created
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      def index
        @companies = current_user.executive_profile.companies
        render json: @companies
      end

      private

      def company_params
        params.require(:company).permit(:name)
      end
    end
  end
end
