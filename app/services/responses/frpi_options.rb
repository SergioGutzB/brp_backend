# frozen_string_literal: true

# Internal:
# Paso 1. Calificación de los ítems
# pag 76
#
module Responses
  module FrpiOptions
    QUESTION_MULTIPLIERS_A = {
    group_1: {
      questions: [
        4, 5, 6, 9, 12, 14, 32, 34, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49,
        50, 51, 53, 54, 55, 56, 57, 58, 59,
        60, 61, 62, 63, 64, 65, 66, 67, 68,
        69, 70, 71, 72, 73, 74, 75, 76, 77,
        78, 79, 81, 82, 83, 84, 85, 86, 87,
        88, 89, 90, 91, 92, 93, 94, 95, 96,
        97, 98, 99, 100, 101, 102, 103, 104,
        105
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
        1, 2, 3, 7, 8, 10, 11, 13, 15, 16, 17,
        18, 19, 20, 21, 22, 23, 24, 25, 26,
        27, 28, 29, 30, 31, 33, 35, 36, 37,
        38, 52, 80, 106, 107, 108, 109, 110,
        111, 112, 113, 114, 115, 116, 117,
        118, 119, 120, 121, 122, 123
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

    QUESTION_MULTIPLIERS_B = {
    group_1: {
      questions: [
        4, 5, 6, 9, 12, 14, 22, 24, 29, 30,
        31, 32, 33, 34, 35, 36, 37, 38, 39,
        40, 41, 42, 43, 44, 45, 46, 47, 48,
        49, 50, 51, 52, 53, 54, 55, 56, 57,
        58, 59, 60, 61, 62, 63, 64, 65, 67,
        68, 69, 70, 71, 72, 73, 74, 75, 76,
        77, 78, 79, 80, 81, 82, 83, 84, 85,
        86, 87, 88, 97
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
        1, 2, 3, 7, 8, 10, 11, 13, 15, 16, 17,
        18, 19, 20, 21, 23, 25, 26, 27, 28,
        66, 89, 90, 91, 92, 93, 94, 95, 96
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
  end
end
