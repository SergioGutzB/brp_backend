# frozen_string_literal: true

module Api
  module V1
    class ResponsesController < ApplicationController
      require 'csv'

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

      def import_from_csv
        if import_csv_permitted_params.nil?
          render json: { error: 'No se proporcionó un archivo' }, status: :bad_request
          return
        end

        file = import_csv_permitted_params[:file]

        begin
          result = Responses::CsvImportService.new(file, import_csv_permitted_params).call
          if result[:success]
            render json: { message: 'Respuestas importadas exitosamente', data: result[:data] }, status: :ok
          else
            render json: { error: result[:error] }, status: :unprocessable_entity
          end
        rescue StandardError => exception
          render json: { error: "Ocurrió un error: #{ exception.message }" }, status: :internal_server_error
        end
      end

      private

      def import_csv_permitted_params
        params.permit(:file, :employee_profile_id, :brp_id)
      end

      def response_params
        params.require(:response).permit(:employee_profile_id, :question_id, :brp_id, :answer)
      end
    end
  end
end
