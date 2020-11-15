# frozen_string_literal: true

module Identifiable
  module Stylists
    class Alphanumeric
      def initialize(record:)
        @record = record
      end

      def random_id
        SecureRandom.alphanumeric(@record.class.identifiable_length)
      end
    end
  end
end
