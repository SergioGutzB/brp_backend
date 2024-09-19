# frozen_string_literal: true

module Results
  module Risks
    class BFrpiDimensions # rubocop:disable Metrics/ClassLength
      def initialize(total, dimension)
        @total = total
        @dimension = dimension
      end

      def call
        send("risk_#{ dimension.downcase }")
      end

      private

      attr_reader :total, :dimension

      def risk_lrst_cl
        case total
        when 38.6..Float::INFINITY then :very_high
        when 25.1..38.5 then :high
        when 13.6..25.0 then :medium
        when 3.9..13.5 then :low
        else :very_low
        end
      end

      def risk_lrst_rst
        case total
        when 37.6..Float::INFINITY then :very_high
        when 27.2..37.5 then :high
        when 14.7..27.1 then :medium
        when 6.4..14.6 then :low
        else :very_low
        end
      end

      def risk_lrst_rd
        case total
        when 50.1..Float::INFINITY then :very_high
        when 30.1..50.0 then :high
        when 20.1..30.0 then :medium
        when 5.1..20.0 then :low
        else :very_low
        end
      end

      def risk_cst_cr
        case total
        when 30.1..Float::INFINITY then :very_high
        when 15.1..30.0 then :high
        when 5.1..15.0 then :medium
        when 1.0..5.0 then :low
        else :very_low
        end
      end

      def risk_cst_c
        case total
        when 50.1..Float::INFINITY then :very_high
        when 25.1..50.0 then :high
        when 16.8..25.0 then :medium
        when 1.0..16.7 then :low
        else :very_low
        end
      end

      def risk_cst_pmc
        case total
        when 58.4..Float::INFINITY then :very_high
        when 41.8..58.3 then :high
        when 33.4..41.7 then :medium
        when 16.8..33.3 then :low
        else :very_low
        end
      end

      def risk_cst_odhc
        case total
        when 56.4..Float::INFINITY then :very_high
        when 37.6..56.3 then :high
        when 25.1..37.5 then :medium
        when 12.6..25.0 then :low
        else :very_low
        end
      end

      def risk_cst_cat
        case total
        when 75.1..Float::INFINITY then :very_high
        when 66.8..75.0 then :high
        when 50.1..66.7 then :medium
        when 33.4..50.0 then :low
        else :very_low
        end
      end

      def risk_dt_daef
        case total
        when 48.0..Float::INFINITY then :very_high
        when 39.7..47.9 then :high
        when 31.4..39.6 then :medium
        when 23.0..31.3 then :low
        else :very_low
        end
      end

      def risk_dt_de
        case total
        when 47.3..Float::INFINITY then :very_high
        when 39.0..47.2 then :high
        when 27.9..38.9 then :medium
        when 19.5..27.8 then :low
        else :very_low
        end
      end

      def risk_dt_dc
        case total
        when 50.1..Float::INFINITY then :very_high
        when 41.8..50.0 then :high
        when 33.4..41.7 then :medium
        when 16.8..33.3 then :low
        else :very_low
        end
      end

      def risk_dt_itsee
        case total
        when 50.1..Float::INFINITY then :very_high
        when 31.4..50.0 then :high
        when 25.1..31.3 then :medium
        when 12.6..25.0 then :low
        else :very_low
        end
      end

      def risk_dt_dcm
        case total
        when 85.1..Float::INFINITY then :very_high
        when 75.1..85.0 then :high
        when 65.1..75.0 then :medium
        when 50.1..65.0 then :low
        else :very_low
        end
      end

      def risk_dt_djt
        case total
        when 58.4..Float::INFINITY then :very_high
        when 45.9..58.3 then :high
        when 37.6..45.8 then :medium
        when 25.1..37.5 then :low
        else :very_low
        end
      end

      def risk_rt_rdpotr
        case total
        when 18.9..Float::INFINITY then :very_high
        when 12.6..18.8 then :high
        when 6.4..12.5 then :medium
        when 1.0..6.3 then :low
        else :very_low
        end
      end

      def risk_rt_rc
        case total
        when 37.6..Float::INFINITY then :very_high
        when 25.1..37.5 then :high
        when 12.6..25.0 then :medium
        when 1.0..12.5 then :low
        else :very_low
        end
      end
    end
  end
end
