# frozen_string_literal: true

module Identifiable
  class Stylist
    VALID_STYLES = %i[numeric alphanumeric uuid].freeze

    def initialize(record:)
      @record = record
      @stylist = stylist
    end

    def random_id
      @stylist.random_id
    end

    private

    def stylist
      case @record.class.identifiable_style
      when :numeric then Identifiable::Stylists::Numeric.new(record: @record)
      when :alphanumeric then Identifiable::Stylists::Alphanumeric.new(record: @record)
      when :uuid then Identifiable::Stylists::Uuid.new
      else
        raise Identifiable::Errors::StyleMustBeAValidStyle
      end
    end
  end
end
