# frozen_string_literal: true

class NotIdColumnUser < User
  identifiable column: :public_id
end
