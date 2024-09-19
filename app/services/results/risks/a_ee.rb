# frozen_string_literal: true

module Results
  module Risks
    class AEe
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
        when 25.1..Float::INFINITY then :very_high
        when 17.8..25.0 then :high
        when 12.7..17.7 then :medium
        when 7.9..12.6 then :low
        else :very_low
        end
      end
    end
  end
end
