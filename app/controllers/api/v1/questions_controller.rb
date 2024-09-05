# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
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
