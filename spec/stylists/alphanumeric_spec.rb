# frozen_string_literal: true

RSpec.describe Identifiable::Stylists::Alphanumeric do
  let(:record) { IdentifiedAlphanumericUser.create(name: "Jane Doe") }
  let(:alphanumeric_stylist) { Identifiable::Stylists::Alphanumeric.new(record: record) }

  describe "methods" do
    describe "#random_id" do
      it "returns an alphanumeric string" do
        expect(alphanumeric_stylist.random_id).to be_a String
        expect(alphanumeric_stylist.random_id).to match(/\A[a-zA-Z0-9]*\z/)
      end

      context "when the record's length is set to 16" do
        let(:record) { IdentifiedAlphanumericLength16User.create(name: "Jane Doe") }

        it "returns a string 16 characters long" do
          expect(alphanumeric_stylist.random_id.length).to eq 16
        end
      end

      context "when the record's length is set to 128" do
        let(:record) { IdentifiedAlphanumericLength128User.create(name: "Jane Doe") }

        it "returns a string 128 characters long" do
          expect(alphanumeric_stylist.random_id.length).to eq 128
        end
      end
    end
  end
end
