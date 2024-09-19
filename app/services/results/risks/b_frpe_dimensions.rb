# frozen_string_literal: true

module Results
  module Risks
    class BFrpeDimensions
      def initialize(total, dimension)
        @total = total
        @dimension = dimension
      end

      def call
        send("risk_#{ dimension.downcase }")
      end

      private

      attr_reader :total, :dimension

      def risk_tft
        case total
        when 50.1..Float::INFINITY then :very_high
        when 37.6..50.0 then :high
        when 25.1..37.5 then :medium
        when 6.4..25.0 then :low
        else :very_low
        end
      end

      def risk_rf
        case total
        when 50.1..Float::INFINITY then :very_high
        when 33.4..50.0 then :high
        when 25.1..33.3 then :medium
        when 8.4..25.0 then :low
        else :very_low
        end
      end

      def risk_segf
        case total
        when 50.1..Float::INFINITY then :very_high
        when 33.4..50.0 then :high
        when 25.1..33.3 then :medium
        when 8.4..25.0 then :low
        else :very_low
        end
      end

      def risk_cri
        case total
        when 35.1..Float::INFINITY then :very_high
        when 25.1..35.0 then :high
        when 15.1..25.0 then :medium
        when 5.1..15.0 then :low
        else :very_low
        end
      end

      def risk_cve
        case total
        when 27.9..Float::INFINITY then :very_high
        when 16.8..27.8 then :high
        when 11.2..16.7 then :medium
        when 5.7..11.1 then :low
        else :very_low
        end
      end

      def risk_ieet
        case total
        when 41.8..Float::INFINITY then :very_high
        when 25.1..41.7 then :high
        when 16.8..25.0 then :medium
        when 1.0..16.7 then :low
        else :very_low
        end
      end

      def risk_dvtv
        case total
        when 43.9..Float::INFINITY then :very_high
        when 25.1..43.8 then :high
        when 12.6..25.0 then :medium
        when 1.0..12.5 then :low
        else :very_low
        end
      end
    end
  end
end
