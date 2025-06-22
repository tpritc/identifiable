# frozen_string_literal: true

module Identifiable
  module Stylists
  end
end

require "active_record"
require "identifiable/stylist"
require "identifiable/stylists/alphanumeric"
require "identifiable/stylists/numeric"
require "identifiable/stylists/uuid"
require "identifiable/errors"
require "identifiable/model"
require "identifiable/version"

ActiveRecord::Base.include Identifiable::Model
