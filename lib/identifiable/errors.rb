# frozen_string_literal: true

module Identifiable
  module Errors
    class ColumnMustBeASymbolError < StandardError
      def initialize(column_value)
        column_value_string = column_value.to_s || 'nil'
        column_value_class = column_value.class.to_s
        super("The identifiable's column must be a symbol. You passed in #{column_value_string}, which was a #{column_value_class}.")
      end
    end

    class ColumnCannotBeIdError < StandardError
      def initialize
        super('The identifiable\'s column cannot be :id, since that\'s your primary key. You should create another index column in your table with a name like :public_id.')
      end
    end

    class ColumnMustExistInTheTableError < StandardError
      def initialize(column_value, valid_columns:)
        column_value_string = column_value.to_s || 'nil'
        super("The identifiable's column must exist on the table for this model. You passed in #{column_value_string}, but the valid columns are: #{valid_columns}")
      end
    end

    class StyleMustBeAValidStyleError < StandardError
      def initialize(style_value)
        style_value_string = style_value.to_s || 'nil'
        super("The identifiable\'s style must be a valid stylist. You passed in #{style_value_string}, but the valid options are: #{Identifiable::Stylist::VALID_STYLES}")
      end
    end

    class LengthMustBeAnIntegerError < StandardError
      def initialize
        super('The identifiable\'s length must be an Integer.')
      end
    end

    class LengthIsTooShortError < StandardError
      def initialize
        super('The identifiable\'s length must be at least 4.')
      end
    end

    class LengthIsTooLongError < StandardError
      def initialize
        super('The identifiable\'s length cannot be more than 128.')
      end
    end

    class LengthMustBeNilIfStyleIsUuidError < StandardError
      def initialize
        super('The identifiable\'s length cannot be set if you\'re using the :uuid style, because UUIDs have a fixed length. You should remove the length parameter.')
      end
    end

    class RanOutOfAttemptsToSetPublicIdError < StandardError
      def initialize
        super('We tried 100 times to find an unused public ID, but we could not find one. You should increase the length parameter of the public ID.')
      end
    end
  end
end
