# frozen_string_literal: true

module Results
  module Risks
    class AFrpeDimensions
      def initialize(total, domain)
        @total = total
        @domain = domain
      end

      def call
        send("risk_#{ domain.downcase }")
      end

      private

      attr_reader :total, :domain

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

      def risk_cri
        case total
        when 30.1..Float::INFINITY then :very_high
        when 20.1..30.0 then :high
        when 10.1..20.0 then :medium
        when 1.0..10.0 then :low
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

      def risk_cve
        case total
        when 22.3..Float::INFINITY then :very_high
        when 14.0..22.2 then :high
        when 11.2..13.9 then :medium
        when 5.7..11.1 then :low
        else :very_low
        end
      end

      def risk_ieet
        case total
        when 41.8..Float::INFINITY then :very_high
        when 25.1..41.7 then :high
        when 16.8..25.0 then :medium
        when 8.4..16.7 then :low
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
