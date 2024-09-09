# frozen_string_literal: true

module Api
  module V1
    class ResponsesController < ApplicationController
      def create
        service = Responses::CreateService.new(
          employee_profile_id: response_params[:employee_profile_id],
          question_id: response_params[:question_id],
          brp_id: response_params[:brp_id],
          answer: response_params[:answer]
        )

        result = service.call

        if result[:success]
          render json: result[:response], status: :created
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def response_params
        params.require(:response).permit(:employee_profile_id, :question_id, :brp_id, :answer)
      end
    end
  end
end
