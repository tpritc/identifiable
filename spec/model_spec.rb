# frozen_string_literal: true

RSpec.describe Identifiable::Model do
  describe 'validations' do
    describe '#_identifiable_validate_column_must_be_a_symbol' do
      context 'when passing the column parameter a symbol' do
        it 'does not raise an error when required' do
          expect { require 'db/models/columns/symbol_column_user' }.not_to raise_error
        end
      end

      context 'when passing the column parameter something other than a symbol' do
        it 'raises a ColumnMustBeASymbolError when required' do
          expect { require 'db/models/columns/string_column_user' }.to raise_error(Identifiable::Errors::ColumnMustBeASymbolError)
        end
      end
    end

    describe '#_identifiable_validate_column_cannot_be_id' do
      context 'when passing the column parameter a non-id symbol' do
        it 'does not raise an error when required' do
          expect { require 'db/models/columns/not_id_column_user' }.not_to raise_error
        end
      end

      context 'when passing the column parameter :id' do
        it 'raises a ColumnCannotBeIdError when required' do
          expect { require 'db/models/columns/id_column_user' }.to raise_error(Identifiable::Errors::ColumnCannotBeIdError)
        end
      end
    end

    describe '#_identifiable_validate_column_must_be_in_the_table' do
      context 'when passing the column parameter a column in the table' do
        it 'does not raise an error when required' do
          expect { require 'db/models/columns/in_table_column_user' }.not_to raise_error
        end
      end

      context 'when passing the column parameter a column not in the table' do
        it 'raises a ColumnMustExistInTheTableError when required' do
          expect { require 'db/models/columns/not_in_table_column_user' }.to raise_error(Identifiable::Errors::ColumnMustExistInTheTableError)
        end
      end
    end

    describe '#_identifiable_validate_style_must_be_a_valid_style' do
      context 'when using an alphanumeric style' do
        it 'does not raise an error when required' do
          expect { require 'db/models/styles/alphanumeric_style_user' }.not_to raise_error
        end
      end

      context 'when using a numeric style' do
        it 'does not raise an error when required' do
          expect { require 'db/models/styles/numeric_style_user' }.not_to raise_error
        end
      end

      context 'when using a UUID style' do
        it 'does not raise an error when required' do
          expect { require 'db/models/styles/uuid_style_user' }.not_to raise_error
        end
      end

      context 'when using an invalid style' do
        it 'raise a StyleMustBeAValidStyleError when required' do
          expect { require 'db/models/styles/invalid_style_user' }.to raise_error(Identifiable::Errors::StyleMustBeAValidStyleError)
        end
      end
    end

    describe '#_identifiable_validate_length_must_be_an_integer' do
      context 'when the length parameter is an integer' do
        it 'does not raise an error when required' do
          expect { require 'db/models/length/integer_length_user' }.not_to raise_error
        end
      end

      context 'when the length parameter is not an integer' do
        it 'raises a LengthIsTooShortError when required' do
          expect { require 'db/models/length/not_an_integer_length_user' }.to raise_error(Identifiable::Errors::LengthMustBeAnIntegerError)
        end
      end
    end

    describe '#_identifiable_validate_length_must_be_in_a_valid_range' do
      context 'when the length parameter is too short' do
        it 'raises a LengthIsTooShortError when required' do
          expect { require 'db/models/length/too_short_length_user' }.to raise_error(Identifiable::Errors::LengthIsTooShortError)
        end
      end

      context 'when the length parameter is too long' do
        it 'raises a LengthIsTooLongError when required' do
          expect { require 'db/models/length/too_long_length_user' }.to raise_error(Identifiable::Errors::LengthIsTooLongError)
        end
      end

      context 'when the length parameter is not too long or too short' do
        it 'does not raise an error when required' do
          expect { require 'db/models/length/in_range_length_user' }.not_to raise_error
        end
      end
    end
  end

  describe 'callbacks' do
    describe '#set_public_id!' do
      context 'when a public id already exists on the column' do
        let(:existing_user) { IdentifiedUser.create(name: 'Jane Doe', public_id: 'existing') }

        it 'does not change the public id' do
          expect(existing_user.public_id).to eq 'existing'
        end
      end

      context 'when a public id does not exist on the column yet' do
        context 'when the style is alphanumeric' do
          let(:alphanumeric_user) { IdentifiedAlphanumericUser.create(name: 'Jane Doe') }

          it 'sets an alphanumeric public id on the column' do
            expect(alphanumeric_user.public_id).not_to be nil
            expect(alphanumeric_user.public_id).to match(/\A[a-zA-Z0-9]*\z/)
          end
        end

        context 'when the style is numeric' do
          let(:numeric_user) { IdentifiedNumericUser.create(name: 'Jane Doe') }

          it 'sets a numeric public id on the column' do
            expect(numeric_user.public_id).not_to be nil
            expect(numeric_user.public_id).to match(/\A[0-9]*\z/)
          end
        end

        context 'when the style is uuid' do
          let(:uuid_user) { IdentifiedUuidUser.create(name: 'Jane Doe') }

          it 'sets a uuid public id on the column' do
            expect(uuid_user.public_id).not_to be nil
            expect(uuid_user.public_id).to match(/\A\w{8}-\w{4}-\w{4}-\w{4}-\w{12}\z/)
          end
        end
      end
    end
  end

  describe 'methods' do
    describe '.find_by_public_id' do
      context 'when passed an existing public id' do
        let(:existing_user) { IdentifiedUser.create(name: 'Jane Doe') }
        let(:existing_public_id) { existing_user.public_id }

        it 'returns the object for that public id' do
          expect(IdentifiedUser.find_by_public_id(existing_public_id)).to eq existing_user
        end
      end

      context 'when passed a public id that does not exist' do
        it 'returns nil' do
          expect(IdentifiedUser.find_by_public_id('non-existant-public-id')).to be nil
        end
      end
    end

    describe '.find_by_public_id!' do
      context 'when passed an existing public id' do
        let(:existing_user) { IdentifiedUser.create(name: 'Jane Doe') }
        let(:existing_public_id) { existing_user.public_id }

        it 'returns the object for that public id' do
          expect(IdentifiedUser.find_by_public_id!(existing_public_id)).to eq existing_user
        end
      end

      context 'when passed a public id that does not exist' do
        it 'raises an ActiveRecord::RecordNotFound error' do
          expect { IdentifiedUser.find_by_public_id!('non-existant-public-id') }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe '#to_key' do
      let(:user) { IdentifiedUser.create(name: 'Jane Doe') }

      it 'returns the public id' do
        expect(user.to_key).to eq [user.public_id]
      end

      it 'does not return the standard id' do
        expect(user.to_key).not_to eq [user.id]
      end
    end

    describe '#to_param' do
      let(:user) { IdentifiedUser.create(name: 'Jane Doe') }

      it 'returns the public id' do
        expect(user.to_param).to eq user.public_id
      end

      it 'does not return the standard id' do
        expect(user.to_param).not_to eq user.id.to_s
      end
    end
  end
end
