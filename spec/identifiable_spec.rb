# frozen_string_literal: true

RSpec.describe Identifiable do
  it 'has a version number' do
    expect(Identifiable::VERSION).not_to be nil
  end
end
