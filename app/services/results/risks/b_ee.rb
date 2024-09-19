# frozen_string_literal: true

module Results
  module Risks
    class BEe
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
        when 23.5..Float::INFINITY then :very_high
        when 17.1..23.4 then :high
        when 11.9..17.0 then :medium
        when 6.6..11.8 then :low
        else :very_low
        end
      end
    end
  end
end
