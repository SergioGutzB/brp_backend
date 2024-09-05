# frozen_string_literal: true

module Questions
  class QuestionService
    def initialize(form_type:, abbreviation:)
      @form_type = form_type
      @abbreviation = abbreviation
    end

    def fetch_questions
      # Fetch the questionnaires based on form_type and abbreviation
      questionnaires = Questionnaire.where(abbreviation: @abbreviation)
      form_type = FormType.find_by(name: @form_type)

      # Fetch questions related to the questionnaires
      questions = Question.where(questionnaire: questionnaires, form_type:)

      # Map questions to include translated text
      questions.map do |question|
        {
          number: question.number,
          text: translate_question_text(question.number)
        }
      end
    end

    private

    def translate_question_text(number)
      # Fetch the translated text for the given question number
      I18n.t("form_types.#{ @form_type }.#{ @abbreviation }.#{ number }",
        default: "Translation missing for #{ number }")
    end
  end
end
