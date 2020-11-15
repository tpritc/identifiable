# frozen_string_literal: true

module Identifiable
  module Stylists
    class Numeric
      def initialize(record:)
        @record = record
        @scale = scale
      end

      def random_id
        (SecureRandom.random_number(@scale.max - @scale.min) + @scale.min).to_s
      end

      private

      def scale
        length = @record.class.identifiable_length

        minimum = 10**(length - 1)
        maximum = (10**length) - 1

        minimum..maximum
      end
    end
  end
end
