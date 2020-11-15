# frozen_string_literal: true

class User < ActiveRecord::Base
end

class IdentifiedUser < User
  identifiable
end

class IdentifiedAlphanumericUser < User
  identifiable style: :alphanumeric
end

class IdentifiedAlphanumericLength16User < User
  identifiable style: :alphanumeric, length: 16
end

class IdentifiedAlphanumericLength128User < User
  identifiable style: :alphanumeric, length: 128
end

class IdentifiedNumericUser < User
  identifiable style: :numeric
end

class IdentifiedNumericLength16User < User
  identifiable style: :numeric, length: 16
end

class IdentifiedNumericLength128User < User
  identifiable style: :numeric, length: 128
end

class IdentifiedUuidUser < User
  identifiable style: :uuid
end
