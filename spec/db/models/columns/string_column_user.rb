# frozen_string_literal: true

class StringColumnUser < User
  identifiable column: 'public_id'
end
