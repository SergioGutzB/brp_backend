# frozen_string_literal: true

module Results
  module Risks
    class BFrpiDomains
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
        when 38.4..Float::INFINITY then :very_high
        when 26.8..38.3 then :high
        when 17.6..26.7 then :medium
        when 8.4..17.5 then :low
        else :very_low
        end
      end

      def risk_cst
        case total
        when 43.2..Float::INFINITY then :very_high
        when 34.8..43.1 then :high
        when 26.5..34.7 then :medium
        when 19.5..26.4 then :low
        else :very_low
        end
      end

      def risk_dt
        case total
        when 44.3..Float::INFINITY then :very_high
        when 37.9..44.2 then :high
        when 33.4..37.8 then :medium
        when 27.0..33.3 then :low
        else :very_low
        end
      end

      def risk_rt
        case total
        when 27.6..Float::INFINITY then :very_high
        when 17.6..27.5 then :high
        when 10.1..17.5 then :medium
        when 2.6..10.0 then :low
        else :very_low
        end
      end
    end
  end
end
