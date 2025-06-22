# frozen_string_literal: true

RSpec.describe Identifiable::Configuration do
  let(:config) { described_class.new }

  describe "#initialize" do
    it "sets default values" do
      expect(config.overwrite_to_key).to be_truthy
      expect(config.overwrite_to_param).to be_truthy
    end
  end

  describe "#overwrite_to_key" do
    it "can be read" do
      expect(config.overwrite_to_key).to be_truthy
    end

    it "can be set to false" do
      config.overwrite_to_key = false
      expect(config.overwrite_to_key).to be_falsey
    end

    it "can be set to true" do
      config.overwrite_to_key = false
      config.overwrite_to_key = true
      expect(config.overwrite_to_key).to be_truthy
    end
  end

  describe "#overwrite_to_param" do
    it "can be read" do
      expect(config.overwrite_to_param).to be_truthy
    end

    it "can be set to false" do
      config.overwrite_to_param = false
      expect(config.overwrite_to_param).to be_falsey
    end

    it "can be set to true" do
      config.overwrite_to_param = false
      config.overwrite_to_param = true
      expect(config.overwrite_to_param).to be_truthy
    end
  end
end
