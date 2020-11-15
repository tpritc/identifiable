# frozen_string_literal: true

class NotAnIntegerLengthUser < User
  identifiable length: 'bad'
end
