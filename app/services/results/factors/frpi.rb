# frozen_string_literal: true

module Results
  module Factors
    module Frpi
      # Tabla 26. Factores de transformación para los dominios de las formas A y B
      # pag. 82
      #
      TRANSFORMATION_DOMAIN_FACTORS = {
        lrst: { A: 164, B: 120 },
        cst: { A: 84, B: 72 },
        dt: { A: 200, B: 156 },
        rt: { A: 44, B: 40 }
      }.freeze

      TRANSFORMATION_FACTORS = {
         lrst: {
           cl: {
             A: 52,
             B: 52
           },
           rst: {
             A: 56,
             B: 48
             },
           rd: {
             A: 20,
             B: 20
            },
           rc: {
            A: 36,
            B: -1
          }
         },
         cst: {
          cr: {
            A: 28,
            B: 20
          },
          c: {
            A: 12,
            B: 12
          },
          pmc: {
            A: 16,
            B: 12
          },
          odhc: {
            A: 16,
            B: 16
          },
          cat: {
            A: 12,
            B: 12
          }
        },
         dt: {
          daef: {
             A: 48,
             B: 48
          },
          de: {
            A: 36,
            B: 36
          },
          dc: {
            A: 24,
            B: 12
          },
          itsee: {
             A: 16,
             B: 16
          },
          erc: {
            A: 24,
            B: -1
          },
          dcm: {
             A: 20,
             B: 20
          },
          cr: {
             A: 20,
             B: -1
          },
          djt: {
             A: 12,
             B: 24
          }
        },
         rt: {
          rdpotr: {
            A: 20,
            B: 16
          },
          rc: {
              A: 24,
              B: 24
          }
        }
       }.freeze
    end
  end
end
