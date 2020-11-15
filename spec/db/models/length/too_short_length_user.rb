# frozen_string_literal: true

class TooShortLengthUser < User
  identifiable length: 3
end
