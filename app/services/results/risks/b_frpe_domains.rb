# frozen_string_literal: true

module Results
  module Risks
    class BFrpeDomains
      def initialize(total)
        @total = total
      end

      def call
        risk
      end

      private

      attr_reader :total

      def risk
        case total
        when 32.4..Float::INFINITY then :very_high
        when 24.3..32.3 then :high
        when 17.8..24.2 then :medium
        when 13.0..17.7 then :low
        else :very_low
        end
      end
    end
  end
end
