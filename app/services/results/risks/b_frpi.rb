# frozen_string_literal: true

module Results
  module Risks
    class BFrpi
      def initialize(total)
        @total = total
      end

      def call
        risk
      end

      private

      attr_reader :total, :domain

      def risk
        case total
        when 38.8..Float::INFINITY then :very_high
        when 31.3..38.7 then :high
        when 26.1..31.2 then :medium
        when 20.7..26.0 then :low
        else :very_low
        end
      end
    end
  end
end
