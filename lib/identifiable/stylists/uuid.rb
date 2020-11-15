# frozen_string_literal: true

module Identifiable
  module Stylists
    class Uuid
      def random_id
        SecureRandom.uuid
      end
    end
  end
end
