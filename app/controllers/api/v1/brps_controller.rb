# frozen_string_literal: true

module Api
  module V1
    class BrpsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_executive

      def create
        service = Brps::CreateService.new(brp_params)
        @brp = service.execute!
        render json: @brp, status: :created
      end

      def by_company
        @brps = Brp.where(company_id: params[:company_id])
        render json: @brps, status: :ok
      end

      private

      def brp_params
        params.require(:brp).permit(:company_id, :year)
      end
    end
  end
end
