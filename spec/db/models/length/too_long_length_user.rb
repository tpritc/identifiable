# frozen_string_literal: true

class TooLongLengthUser < User
  identifiable length: 1024
end
