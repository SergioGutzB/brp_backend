# frozen_string_literal: true

module Results
  module Risks
    class AFrpi
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
        when 38.1..Float::INFINITY then :very_high
        when 31.6..38.0 then :high
        when 25.9..31.5 then :medium
        when 19.8..25.8 then :low
        else :very_low
        end
      end
    end
  end
end
