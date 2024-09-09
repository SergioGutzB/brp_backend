# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authorize_employee, only: %i[index]
      before_action :authorize_executive, only: %i[index]

      def index
        form_type = params[:form_type]
        abbreviation = params[:abbreviation]

        service = Questions::QuestionService.new(form_type:, abbreviation:)
        @questions = service.fetch_questions

        render json: @questions
      end
    end
  end
end
