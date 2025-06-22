# frozen_string_literal: true

RSpec.describe Identifiable do
  it "has a version number" do
    expect(Identifiable::VERSION).not_to be nil
  end

  describe ".configure" do
    after do
      # Reset configuration after each test
      Identifiable.configure do |config|
        config.overwrite_to_key = true
        config.overwrite_to_param = true
      end
    end

    it "yields a configuration object" do
      expect { |b| Identifiable.configure(&b) }.to yield_with_args(Identifiable.configuration)
    end

    it "allows configuring overwrite_to_key" do
      Identifiable.configure do |config|
        config.overwrite_to_key = false
      end

      expect(Identifiable.configuration.overwrite_to_key).to be_falsey
    end

    it "allows configuring overwrite_to_param" do
      Identifiable.configure do |config|
        config.overwrite_to_param = false
      end

      expect(Identifiable.configuration.overwrite_to_param).to be_falsey
    end

    it "allows configuring multiple options at once" do
      Identifiable.configure do |config|
        config.overwrite_to_key = false
        config.overwrite_to_param = false
      end

      expect(Identifiable.configuration.overwrite_to_key).to be_falsey
      expect(Identifiable.configuration.overwrite_to_param).to be_falsey
    end
  end

  describe ".configuration" do
    after do
      # Reset configuration after each test
      Identifiable.configure do |config|
        config.overwrite_to_key = true
        config.overwrite_to_param = true
      end
    end

    it "returns the same configuration object on multiple calls" do
      config1 = Identifiable.configuration
      config2 = Identifiable.configuration
      expect(config1).to be(config2)
    end

    it "returns a configuration object that responds to configuration methods" do
      config = Identifiable.configuration
      expect(config).to respond_to(:overwrite_to_key)
      expect(config).to respond_to(:overwrite_to_param)
      expect(config).to respond_to(:overwrite_to_key=)
      expect(config).to respond_to(:overwrite_to_param=)
    end

    it "maintains configuration changes across calls" do
      Identifiable.configure do |config|
        config.overwrite_to_key = false
        config.overwrite_to_param = false
      end

      config = Identifiable.configuration
      expect(config.overwrite_to_key).to be_falsey
      expect(config.overwrite_to_param).to be_falsey

      # Should persist
      config_again = Identifiable.configuration
      expect(config_again.overwrite_to_key).to be_falsey
      expect(config_again.overwrite_to_param).to be_falsey
    end
  end
end
