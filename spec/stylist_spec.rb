# frozen_string_literal: true

RSpec.describe Identifiable::Stylist do
  let(:record) { IdentifiedAlphanumericUser.create(name: 'Jane Doe') }
  let(:stylist) { Identifiable::Stylist.new(record: record) }

  describe 'methods' do
    describe '#random_id' do
      context 'when the style is alphanumeric' do
        it 'returns an alphanumeric string' do
          expect(stylist.random_id).to be_a String
          expect(stylist.random_id).to match(/\A[a-zA-Z0-9]*\z/)
        end
      end

      context 'when the style is numeric' do
        let(:record) { IdentifiedNumericUser.create(name: 'Jane Doe') }

        it 'returns a numeric string' do
          expect(stylist.random_id).to be_a String
          expect(stylist.random_id).to match(/\A[0-9]*\z/)
        end
      end

      context 'when the style is uuid' do
        let(:record) { IdentifiedUuidUser.create(name: 'Jane Doe') }

        it 'returns a uuid string' do
          expect(stylist.random_id).to be_a String
          expect(stylist.random_id).to match(/\A\w{8}-\w{4}-\w{4}-\w{4}-\w{12}\z/)
        end
      end
    end
  end
end
