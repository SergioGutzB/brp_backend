# frozen_string_literal: true

module Results
  module Risks
    class AFrpiDimensions # rubocop:disable Metrics/ClassLength
      def initialize(total, domain)
        @total = total
        @domain = domain
      end

      def call
        send("risk_#{ domain.downcase }")
      end

      private

      attr_reader :total, :domain

      # LRST
      def risk_lrst_cl
        case total
        when 46.3..Float::INFINITY then :very_high
        when 30.9..46.2 then :high
        when 15.5..30.8 then :medium
        when 3.9..15.4 then :low
        else :very_low
        end
      end

      def risk_lrst_rst
        case total
        when 37.6..Float::INFINITY then :very_high
        when 25.1..37.5 then :high
        when 16.2..25.0 then :medium
        when 5.5..16.1 then :low
        else :very_low
        end
      end

      def risk_lrst_rd
        case total
        when 55.1..Float::INFINITY then :very_high
        when 40.1..55.0 then :high
        when 25.1..40.0 then :medium
        when 10.1..25.0 then :low
        else :very_low
        end
      end

      def risk_lrst_rc
        case total
        when 47.3..Float::INFINITY then :very_high
        when 33.4..47.2 then :high
        when 25.1..33.3 then :medium
        when 14.0..25.0 then :low
        else :very_low
        end
      end

      # CST
      def risk_cst_cr
        case total
        when 39.4..Float::INFINITY then :very_high
        when 21.5..39.3 then :high
        when 10.8..21.4 then :medium
        when 1.0..10.7 then :low
        else :very_low
        end
      end

      def risk_cst_c
        case total
        when 50.1..Float::INFINITY then :very_high
        when 33.4..50.0 then :high
        when 16.8..33.3 then :medium
        when 1.0..16.7 then :low
        else :very_low
        end
      end

      def risk_cst_pmc
        case total
        when 50.1..Float::INFINITY then :very_high
        when 37.6..50.0 then :high
        when 25.1..37.5 then :medium
        when 12.6..25.0 then :low
        else :very_low
        end
      end

      def risk_cst_odhc
        case total
        when 31.4..Float::INFINITY then :very_high
        when 18.9..31.3 then :high
        when 6.4..18.8 then :medium
        when 1.0..6.3 then :low
        else :very_low
        end
      end

      def risk_cst_cat
        case total
        when 58.4..Float::INFINITY then :very_high
        when 41.8..58.3 then :high
        when 25.1..41.7 then :medium
        when 8.4..25.0 then :low
        else :very_low
        end
      end

      # DT
      def risk_dt_daef
        case total
        when 39.7..Float::INFINITY then :very_high
        when 31.4..39.6 then :high
        when 23.0..31.3 then :medium
        when 14.7..22.9 then :low
        else :very_low
        end
      end

      def risk_dt_de
        case total
        when 47.3..Float::INFINITY then :very_high
        when 33.4..47.2 then :high
        when 25.1..33.3 then :medium
        when 16.8..25.0 then :low
        else :very_low
        end
      end

      def risk_dt_dc
        case total
        when 54.3..Float::INFINITY then :very_high
        when 45.9..54.2 then :high
        when 33.4..45.8 then :medium
        when 25.1..33.3 then :low
        else :very_low
        end
      end

      def risk_dt_itsee
        case total
        when 50.1..Float::INFINITY then :very_high
        when 43.9..50.0 then :high
        when 31.4..43.8 then :medium
        when 18.9..31.3 then :low
        else :very_low
        end
      end

      def risk_dt_erc
        case total
        when 79.3..Float::INFINITY then :very_high
        when 66.8..79.2 then :high
        when 54.3..66.7 then :medium
        when 37.6..54.2 then :low
        else :very_low
        end
      end

      def risk_dt_dcm
        case total
        when 90.1..Float::INFINITY then :very_high
        when 80.1..90.0 then :high
        when 70.1..80.0 then :medium
        when 60.1..70.0 then :low
        else :very_low
        end
      end

      def risk_dt_cr
        case total
        when 45.1..Float::INFINITY then :very_high
        when 35.1..45.0 then :high
        when 25.1..35.0 then :medium
        when 15.1..25.0 then :low
        else :very_low
        end
      end

      def risk_dt_djt
        case total
        when 50.1..Float::INFINITY then :very_high
        when 33.4..50.0 then :high
        when 25.1..33.3 then :medium
        when 8.4..25.0 then :low
        else :very_low
        end
      end

      # RT
      def risk_rt_rdpotr
        case total
        when 20.1..Float::INFINITY then :very_high
        when 10.1..20.0 then :high
        when 5.1..10.0 then :medium
        when 1.0..5.0 then :low
        else :very_low
        end
      end

      def risk_rt_rc
        case total
        when 37.6..Float::INFINITY then :very_high
        when 25.1..37.5 then :high
        when 16.8..25.0 then :medium
        when 4.3..16.7 then :low
        else :very_low
        end
      end
    end
  end
end
