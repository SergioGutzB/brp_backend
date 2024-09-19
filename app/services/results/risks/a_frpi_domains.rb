# frozen_string_literal: true

module Results
  module Risks
    class AFrpiDomains
      def initialize(total, domain)
        @total = total
        @domain = domain
      end

      def call
        send("risk_#{ domain.downcase }")
      end

      private

      attr_reader :total, :domain

      def risk_lrst
        case total
        when 34.9..Float::INFINITY then :very_high
        when 25.7..34.8 then :high
        when 17.8..25.6 then :medium
        when 9.2..17.7 then :low
        else :very_low
        end
      end

      def risk_cst
        case total
        when 40.6..Float::INFINITY then :very_high
        when 29.9..40.5 then :high
        when 19.1..29.8 then :medium
        when 10.8..19.0 then :low
        else :very_low
        end
      end

      def risk_dt
        case total
        when 47.6..Float::INFINITY then :very_high
        when 41.6..47.5 then :high
        when 35.1..41.5 then :medium
        when 28.6..35.0 then :low
        else :very_low
        end
      end

      def risk_rt
        case total
        when 29.6..Float::INFINITY then :very_high
        when 20.6..29.5 then :high
        when 11.5..20.5 then :medium
        when 4.6..11.4 then :low
        else :very_low
        end
      end
    end
  end
end
