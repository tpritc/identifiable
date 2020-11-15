# frozen_string_literal: true

module Identifiable
  module Model
    extend ActiveSupport::Concern

    class_methods do
      attr_reader :identifiable_column
      attr_reader :identifiable_style
      attr_reader :identifiable_length

      def identifiable(column: :public_id, style: :numeric, length: 8)
        @identifiable_column = column
        @identifiable_style = style
        @identifiable_length = length

        _identifiable_validate_column_must_be_a_symbol
        _identifiable_validate_column_cannot_be_id
        _identifiable_validate_column_must_be_in_the_table
        _identifiable_validate_style_must_be_a_valid_style
        _identifiable_validate_length_must_be_an_integer
        _identifiable_validate_length_must_be_in_a_valid_range

        before_create :set_public_id!
      end

      def find_by_public_id(public_id)
        where(Hash[identifiable_column, public_id]).first
      end

      def find_by_public_id!(public_id)
        result = find_by_public_id(public_id)
        raise ActiveRecord::RecordNotFound unless result.present?

        result
      end

      # We only accept symbols for the column parameter, so we need to raise an
      # error if anything other than a symbol is passed in.
      def _identifiable_validate_column_must_be_a_symbol
        return if @identifiable_column.is_a? Symbol

        raise Identifiable::Errors::ColumnMustBeASymbolError, @identifiable_column
      end

      # The column parameter cannot be :id, since that's reserved for the
      # primary key, so raise an error if the column parameter is :id.
      def _identifiable_validate_column_cannot_be_id
        return unless @identifiable_column == :id

        raise Identifiable::Errors::ColumnCannotBeIdError
      end

      # The column parameter must be in the model's table, so check that the
      # column corresponds to a column in the model's table, and raise an error
      # if it is not.
      def _identifiable_validate_column_must_be_in_the_table
        return if column_names.include? @identifiable_column.to_s

        raise Identifiable::Errors::ColumnMustExistInTheTableError.new(@identifiable_column, valid_columns: column_names)
      end

      # We can only use valid styles, so check that the style parameter is a
      # valid style, and raise an error if it is not.
      def _identifiable_validate_style_must_be_a_valid_style
        return if Identifiable::Stylist::VALID_STYLES.include? @identifiable_style

        raise Identifiable::Errors::StyleMustBeAValidStyleError, @identifiable_style
      end

      # The length parameter must be an Integer, so if it's something else then
      # raise an error.
      def _identifiable_validate_length_must_be_an_integer
        return if @identifiable_length.is_a? Integer

        raise Identifiable::Errors::LengthMustBeAnIntegerError
      end

      # The length parameter can only be within a certain range to prevent
      # public IDs that are too short or too long, so raise an error if the
      # length is too short or too long.
      def _identifiable_validate_length_must_be_in_a_valid_range
        raise Identifiable::Errors::LengthIsTooShortError if @identifiable_length < 4
        raise Identifiable::Errors::LengthIsTooLongError if @identifiable_length > 128
      end
    end

    # If we don't have a public ID yet, this method fetches the stylist for
    # this class and finds a new, valid public id, and assigns it to the public
    # ID column.
    def set_public_id!
      # We don't want to set the public id if there's already a value in the
      # column, so exit early if that's the case.
      return unless self[self.class.identifiable_column].blank?

      # Create a new stylist for this record, that'll return random IDs
      # matching the class' style and length options.
      stylist = Identifiable::Stylist.new(record: self)
      new_public_id = nil

      # Loop until we find an unused public ID or we run out of attempts.
      100.times do
        new_public_id = stylist.random_id
        break if self.class.find_by_public_id(new_public_id).nil?

        new_public_id = nil
      end

      # If we ran out of attempts, this probably means the length is too short,
      # since we kept colliding with existing records. Raise an error to let
      # the developers know that they need to up the length of the public ID.
      raise Identifiable::Errors::RanOutOfAttemptsToSetPublicIdError if new_public_id.nil?

      # If we got this far, we've got a new valid public ID, time to set it!
      self[self.class.identifiable_column] = new_public_id
    end
  end
end
