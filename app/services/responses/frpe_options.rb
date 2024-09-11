# frozen_string_literal: true

module Responses
  module FrpeOptions
    QUESTION_MULTIPLIERS_A = {
    group_1: {
      questions: [
        1, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23,
        25, 27, 29
      ],
      multipliers: {
        'always' => 0,
        'almost_always' => 1,
        'sometimes' => 2,
        'almost_never' => 3,
        'never' => 4
      }
    },
    group_2: {
      questions: [
        2, 3, 6, 24, 26, 28, 30, 31
      ],
      multipliers: {
        'always' => 4,
        'almost_always' => 3,
        'sometimes' => 2,
        'almost_never' => 1,
        'never' => 0
      }
    }
  }.freeze

    QUESTION_MULTIPLIERS_B = QUESTION_MULTIPLIERS_A.freeze
  end
end
