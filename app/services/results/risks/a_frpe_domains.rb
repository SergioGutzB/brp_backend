# frozen_string_literal: true

module Results
  module Risks
    class AFrpeDomains
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
        when 29.1..Float::INFINITY then :very_high
        when 22.7..29.0 then :high
        when 17.0..22.6 then :medium
        when 11.4..17.0 then :low
        else :very_low
        end
      end
    end
  end
end
