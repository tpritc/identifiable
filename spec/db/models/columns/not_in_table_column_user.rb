# frozen_string_literal: true

class NotInTableColumnUser < User
  identifiable column: :other_public_id
end
