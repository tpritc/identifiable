# frozen_string_literal: true

RSpec.describe Identifiable::Stylists::Numeric do
  let(:record) { IdentifiedNumericUser.create(name: 'Jane Doe') }
  let(:numeric_stylist) { Identifiable::Stylists::Numeric.new(record: record) }

  describe 'methods' do
    describe '#random_id' do
      it 'returns a numeric string' do
        expect(numeric_stylist.random_id).to be_a String
        expect(numeric_stylist.random_id).to match(/\A[0-9]*\z/)
      end

      context 'when the record\'s length is set to 16' do
        let(:record) { IdentifiedNumericLength16User.create(name: 'Jane Doe') }

        it 'returns a string 16 characters long' do
          expect(numeric_stylist.random_id.length).to eq 16
        end
      end

      context 'when the record\'s length is set to 128' do
        let(:record) { IdentifiedNumericLength128User.create(name: 'Jane Doe') }

        it 'returns a string 128 characters long' do
          expect(numeric_stylist.random_id.length).to eq 128
        end
      end
    end
  end
end
