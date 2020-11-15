# frozen_string_literal: true

RSpec.describe Identifiable::Stylists::Uuid do
  let(:uuid_stylist) { Identifiable::Stylists::Uuid.new }

  describe 'methods' do
    describe '#random_id' do
      it 'returns a uuid string' do
        expect(uuid_stylist.random_id).to be_a String
        expect(uuid_stylist.random_id).to match(/\A\w{8}-\w{4}-\w{4}-\w{4}-\w{12}\z/)
      end
    end
  end
end
