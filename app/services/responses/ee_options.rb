# frozen_string_literal: true

module Responses
  module EeOptions
    QUESTION_MULTIPLIERS_A = {
    group_1: {
      questions: [
        1, 2, 3, 9, 13, 14, 15, 23, 24
      ],
      multipliers: {
        'always' => 9,
        'almost_always' => 6,
        'sometimes' => 3,
        'almost_never' => 0,
        'never' => 0
      }
    },
    group_2: {
      questions: [
        4, 5, 6, 10, 11, 16, 17, 18, 19, 25,
        26, 27, 28
      ],
      multipliers: {
        'always' => 6,
        'almost_always' => 4,
        'sometimes' => 2,
        'almost_never' => 0,
        'never' => 0
      }
    },
    group_3: {
      questions: [
        7, 8, 12, 20, 21, 22, 29, 30, 31
      ],
      multipliers: {
        'always' => 3,
        'almost_always' => 2,
        'sometimes' => 1,
        'almost_never' => 0,
        'never' => 0
      }
    }
  }.freeze

    QUESTION_MULTIPLIERS_B = QUESTION_MULTIPLIERS_A.freeze
  end
end
