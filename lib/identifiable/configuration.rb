# frozen_string_literal: true

module Identifiable
  class Configuration
    attr_accessor :overwrite_to_key, :overwrite_to_param

    def initialize
      @overwrite_to_key = true
      @overwrite_to_param = true
    end
  end
end
