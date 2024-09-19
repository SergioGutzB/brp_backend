# frozen_string_literal: true

module Results
  module Risks
    class AFrpiDimensions
      RISK = {
        very_high: 'VeryHigh',
        high: 'High',
        medium: 'Medium',
        low: 'Low',
        very_low: 'VeryLow'
      }.freeze

      def initialize(total, domain)
        @total = total
        @domain = domain
      end

      def call
        send("risk_#{ @domain.downcase }")
      end

      private

      # LRST
      def risk_lrst_cl
        return RISK[:very_high] if @total >= 46.3
        return RISK[:high] if @total >= 30.9
        return RISK[:medium] if @total >= 15.5
        return RISK[:low] if @total >= 3.9

        RISK[:very_low]
      end

      def risk_lrst_rst
        return RISK[:very_high] if @total >= 37.6
        return RISK[:high] if @total >= 25.1
        return RISK[:medium] if @total >= 16.2
        return RISK[:low] if @total >= 5.5

        RISK[:very_low]
      end

      def risk_lrst_rd
        return RISK[:very_high] if @total >= 55.1
        return RISK[:high] if @total >= 40.1
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 10.1

        RISK[:very_low]
      end

      def risk_lrst_rc
        return RISK[:very_high] if @total >= 47.3
        return RISK[:high] if @total >= 33.4
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 14.0

        RISK[:very_low]
      end

      # CST
      def risk_cst_cr
        return RISK[:very_high] if @total >= 39.4
        return RISK[:high] if @total >= 21.5
        return RISK[:medium] if @total >= 10.8
        return RISK[:low] if @total >= 1.0

        RISK[:very_low]
      end

      def risk_cst_c
        return RISK[:very_high] if @total >= 50.1
        return RISK[:high] if @total >= 33.4
        return RISK[:medium] if @total >= 16.8
        return RISK[:low] if @total >= 1.0

        RISK[:very_low]
      end

      def risk_cst_pmc
        return RISK[:very_high] if @total >= 50.1
        return RISK[:high] if @total >= 37.6
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 12.6

        RISK[:very_low]
      end

      def risk_cst_odhc
        return RISK[:very_high] if @total >= 31.4
        return RISK[:high] if @total >= 18.9
        return RISK[:medium] if @total >= 6.4
        return RISK[:low] if @total >= 1.0

        RISK[:very_low]
      end

      def risk_cst_cat
        return RISK[:very_high] if @total >= 58.4
        return RISK[:high] if @total >= 41.8
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 8.4

        RISK[:very_low]
      end

      # DT
      def risk_dt_daef
        return RISK[:very_high] if @total >= 39.7
        return RISK[:high] if @total >= 31.4
        return RISK[:medium] if @total >= 23.0
        return RISK[:low] if @total >= 14.7

        RISK[:very_low]
      end

      def risk_dt_de
        return RISK[:very_high] if @total >= 47.3
        return RISK[:high] if @total >= 33.4
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 16.8

        RISK[:very_low]
      end

      def risk_dt_dc
        return RISK[:very_high] if @total >= 54.3
        return RISK[:high] if @total >= 45.9
        return RISK[:medium] if @total >= 33.4
        return RISK[:low] if @total >= 25.1

        RISK[:very_low]
      end

      def risk_dt_itsee
        return RISK[:very_high] if @total >= 50.1
        return RISK[:high] if @total >= 43.9
        return RISK[:medium] if @total >= 31.4
        return RISK[:low] if @total >= 18.9

        RISK[:very_low]
      end

      def risk_dt_erc
        return RISK[:very_high] if @total >= 79.3
        return RISK[:high] if @total >= 66.8
        return RISK[:medium] if @total >= 54.3
        return RISK[:low] if @total >= 37.6

        RISK[:very_low]
      end

      def risk_dt_dcm
        return RISK[:very_high] if @total >= 90.1
        return RISK[:high] if @total >= 80.1
        return RISK[:medium] if @total >= 70.1
        return RISK[:low] if @total >= 60.1

        RISK[:very_low]
      end

      def risk_dt_cr
        return RISK[:very_high] if @total >= 45.1
        return RISK[:high] if @total >= 35.1
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 15.1

        RISK[:very_low]
      end

      def risk_dt_djt
        return RISK[:very_high] if @total >= 50.1
        return RISK[:high] if @total >= 33.4
        return RISK[:medium] if @total >= 25.1
        return RISK[:low] if @total >= 8.4

        RISK[:very_low]
      end

      # RT
      def risk_rt_rdpotr
        return RISK[:very_high] if @total >= 20.1
        return RISK[:high] if @total >= 10.1
        return RISK[:medium] if @total >= 5.1
        return RISK[:low] if @total >= 1.0

        RISK[:very_low]
      end

      def risk_rt_rc
        return RISK[:very_high] if @total >= 37.6
        return RISK[:high] if @total >= 25.1
        return RISK[:medium] if @total >= 16.8
        return RISK[:low] if @total >= 4.3

        RISK[:very_low]
      end
    end
  end
end
